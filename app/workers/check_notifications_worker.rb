require 'json'

class CheckNotificationsWorker                        
    include Sidekiq::Worker
                                          
    def perform

      # First dequeue all pending notifications
      connection_string = "#{
        ENV["QUEUE_PROTOCOL"]
      }://#{
        ENV["QUEUE_USER"]
      }:#{
        ENV["QUEUE_PASSWORD"]
      }@#{
        ENV["QUEUE_URL"]
      }:#{
        ENV["QUEUE_PORT"]
      }/#{
        ENV["QUEUE_VHOST"]
      }?verify_peer=true"

      connection = Bunny.new(
        connection_string,  
      )

      # Stablish connection
      connection.start

      # Create a channel
      channel = connection.create_channel()

      # Declare a queue
      queue_name = ENV['QUEUE_NAME'] 
      queue = channel.queue(
        queue_name,
        :durable => true,
      )

      begin
        queue.subscribe(manual_ack: true, block: false) do |delivery_info, properties, body|
          # Parse message to known structure
          message = JSON.parse(body, object_class: OpenStruct)

          # Create a new notification
          notification = Notification.new(
            noti_title: message.title,
            noti_body: message.body,
            noti_init_date: message.init_date,
            noti_type: "notification",
            noti_active: true,
            noti_should_email: message.should_email,
            noti_email: message.email,
            usr_id: message.user_id
          )

          # Save the notification
          if notification.save()
            puts "Notification saved"
          else
            puts notification.errors.full_messages
          end
          
          # Mark message as processed (ack), it will get deleted from the queue
          channel.ack(delivery_info.delivery_tag, false)
        end
      rescue Interrupt => _
        puts "Closing connection..."
      end
      
      # Perform a simple check to see if the notifications are working
      puts "Checking notifications..."
      
      # Print relevant notifications
      current_time = Time.now

      puts "Time: #{current_time}" 

      pending_notifications = Notification.where(
        noti_init_date: { :$lte => current_time },
        noti_active: true
      )
      pending_notifications.each do |notification|
        #puts "Notification: #{notification.noti_title} - #{notification.noti_init_date}"
        
        if notification.noti_init_date <= current_time && notification.noti_active == true
          puts "Notification: #{notification.noti_title} - #{notification.noti_init_date}"
          notification.update(noti_active: false)

          # Send notification through email if required
          if notification.noti_should_email == true
            puts "Sending email..."
            require 'sib-api-v3-sdk'

            api_instance = SibApiV3Sdk::EmailCampaignsApi.new

            email_campaigns = {
              "name" => "Habitus Notifications",
              "subject" => notification.noti_title,
              "type" => "classic",
              "htmlContent" => %q(
                "<h1>#{notification.noti_title}</h1>"
                "<p1>#{notification.noti_body}</p1>"
              ),
              "sender" => {
                "name" => "#{ENV["SMTP_SENDER_NAME"]}",
                "email" => "#{ENV["SMTP_SENDER_EMAIL"]}"
              }
            }

            begin
              result = api_instance.create_email_campaign(email_campaigns)
              p result
            rescue SibApiV3Sdk::ApiError => e
              puts "Exception when calling EmailCampaignsApi->create_email_campaign: #{e}"
            end
          end
        end
      end

      # Subscriptions take a time to process
      puts "Closing connection..."
      connection.close

    end   
    
  end