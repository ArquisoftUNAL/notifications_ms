class NotificationsController::NotificationsController < ApplicationController
    ## turn off CSRF that won't render a null session
    skip_before_action :verify_authenticity_token
    before_action :getNotification, only: [:updateNotification, :deleteNotification, :showNotification]    

    ##get
    def getNotifications
        notification = Notification.all        
        if notification
            render json: notification, status: :ok
        else
            render json: {msg: "Notification Empty" }, status: :unprocessable_entity
        end
    end

    #get count of notifications in db
    def getNotificationsCount
        notification = Notification.count()        
        if notification
            render json: notification, status: :ok
        else
            render json: {msg: "Notification Empty" }, status: :unprocessable_entity
        end
    end

    #show
    def showNotification
        if @notification
            render json: @notification, status: :ok      
        else
            render json: {msg:"Notification not found"}, status: :unprocessable_entity
        end
    end    

    ##post
    def addNotification
        notification = Notification.new(notificationparams)

        if notification.save()
            render json: notification, status: :ok
        else
            render json: {msg: "Notification not added", error: notification.errors }, status: :unprocessable_entity
        end

    end

    ##put
    def updateNotification
        if @notification
            if @notification.update(notificationparams)
                render json: @notification, status: :ok
            else
                render json: {msg:"Update Failed"}, status: :unprocessable_entity
            end
        else
            render json: {msg:"Notification not found"}, status: :unprocessable_entity
        end
    end

    ##delete
    def deleteNotification
        if @notification
            if @notification.destroy()
                render json: {msg: "Notification Deleted"}, status: :ok
            else
                render json: {msg:"Delete Failed"}, status: :unprocessable_entity
            end
        else
            render json: {msg:"Notification not found"}, status: :unprocessable_entity
        end
    end

    ##private params
    private

    #enter params
    def notificationparams
        params.permit(:not_id, :not_init_date, :not_description, :not_active);
    end

    def getNotification
        @notification = Notification.find(params[:id])
    end
end
