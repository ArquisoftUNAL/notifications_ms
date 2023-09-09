Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  ##GET /about example
  #get "about", to: "about#index"

  ## example
  #get "/", to: "main#index"

  #go to folder reminders_ms_controllers
  namespace :reminders_controller do
    get 'get_reminder', action: :getReminder, controller: :reminders
    post 'add_reminder', action: :addReminder, controller: :reminders
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
