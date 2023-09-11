Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  ##GET /about example
  #get "about", to: "about#index"

  ## example
  #get "/", to: "main#index"

  #go to folder reminders_ms_controllers
  namespace :reminders_controller do
    get 'get_reminders', action: :getReminders, controller: :reminders
    post 'add_reminder', action: :addReminder, controller: :reminders
    get 'show_reminder', action: :showReminder, controller: :reminders
    put 'update_reminder', action: :updateReminder, controller: :reminders
    delete 'delete_reminder', action: :deleteReminder, controller: :reminders
    get 'get_reminders_count', action: :getRemindersCount, controller: :reminders
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
