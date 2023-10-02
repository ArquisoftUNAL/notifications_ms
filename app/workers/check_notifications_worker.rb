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
      }"

      connection = Bunny.new(
        connection_string,  
      )

      # Establecer la conexión
      connection.start

      # Crear un canal
      channel = connection.create_channel

      # Acceder a la cola y consultarla (puedes añadir más operaciones aquí si es necesario)
      queue_name = ENV['QUEUE_NAME']  #nombre de tu cola
      queue = channel.queue(
        queue_name,
        :durable => true,
      )

      begin
        queue.subscribe(manual_ack: true) do |delivery_info, properties, body|
          
          puts "Received message: #{body}"
          
          # Parse message to known structure
          message = JSON.parse(body, object_class: OpenStruct)

          puts "Message: #{message.title} - #{message.body} - #{message.init_date} - #{message.should_email} - #{message.user_id}"

          # Create a new notification
          notification = Notification.new(
            noti_title: message.title,
            noti_body: message.body,
            noti_init_date: message.init_date,
            noti_type: "notification",
            noti_active: true,
            noti_should_email: message.should_email,
            noti_email: "ola",
            usr_id: message.user_id
          )

          # Save the notification
          notification.save

          channel.ack(delivery_info.delivery_tag)
        end
      rescue Interrupt => _
        puts "Closing connection..."
        connection.close
        exit(0)
      end

      connection.close
      exit(0)

      

      # Perform a simple check to see if the notifications are working
      puts "Checking notifications..."
      
      # Print relevant notifications
      current_time = Time.now

      puts "Time: #{current_time}" 

      # Print all notifications
      Notification.all.each do |notification|
        #puts "Notification: #{notification.noti_title} - #{notification.noti_init_date}"
        
        if notification.noti_init_date <= current_time && notification.noti_active == true
          puts "Notification: #{notification.noti_title} - #{notification.noti_init_date}"
          notification.update(noti_active: false)
        end
      end

      

      
    end   
    
  end


