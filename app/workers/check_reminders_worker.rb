class CheckRemindersWorker                        
    include Sidekiq::Worker
                                          
    def perform()                     
      # Perform a simple check to see if the reminders are working
      puts "Checking reminders..."
      
      # Print all reminders
      Reminder.all.each do |reminder|
        puts "Reminder: #{reminder.rem_id} - #{reminder.rem_description}"
      end
    end               
  end