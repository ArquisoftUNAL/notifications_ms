class CheckNotificationsWorker                        
    include Sidekiq::Worker
                                          
    def perform()                     
      # Perform a simple check to see if the notifications are working
      puts "Checking notifications..."
      
      # Print all notifications
      Notification.all.each do |notification|
        puts "Notification: #{notification.not_id} - #{notification.not_description}"
      end
    end               
  end