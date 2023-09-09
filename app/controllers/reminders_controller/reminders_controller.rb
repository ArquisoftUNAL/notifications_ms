class RemindersController::RemindersController < ApplicationController
    ## turn off CSRF that won't render a null session
    skip_before_action :verify_authenticity_token
    
    ##get
    def getReminder
        reminder = Reminder.all
        if reminder
            render json: reminder, status: :ok
        else
            render json: { msg: "user Empty" }, status: :unprocessable_entity
        end
    end

    ##post
    def addReminder
        reminder = Reminder.new(rem_init_date:"prueba", rem_description:"prueba", rem_active:true)#(reminderparams)

        if reminder.save()
            render json: reminder, status: :ok
        else
            render json: {msg: "Reminder not added"}, status: :unprocessable_entity
        end

    end

    ##put
    def updateReminder

    end

    ##delete
    def deleteReminder

    end

    ##private params
    #private

    #def reminderparams
    #    params.permit(:rem_init_date, :rem_description, :rem_active);
    #end
end
