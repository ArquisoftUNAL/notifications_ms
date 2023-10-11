class NotifierMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def welcome_email
        @user = params[:user]
        @noti_title = params[:noti_title]
        @noti_body = params[:noti_body]
        #@url  = 'http://example.com/login'
        mail(to: @user, subject: 'New Notification!')
    end
end
