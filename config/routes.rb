Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  ##GET /about example
  #get "about", to: "about#index"

  ## example
  #get "/", to: "main#index"

  #go to folder notifications_ms_controllers
  namespace :notifications_controller do
    get 'get_notifications', action: :getNotifications, controller: :notifications
    post 'add_notification', action: :addNotification, controller: :notifications
    get 'show_notification', action: :showNotification, controller: :notifications
    put 'update_notification', action: :updateNotification, controller: :notifications
    delete 'delete_notification', action: :deleteNotification, controller: :notifications
    get 'get_notifications_count', action: :getNotificationsCount, controller: :notifications
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
