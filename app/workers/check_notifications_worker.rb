class CheckNotificationsWorker                        
    include Sidekiq::Worker
                                          
    def perform()                     
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


