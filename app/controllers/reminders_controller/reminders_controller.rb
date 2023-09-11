class RemindersController::RemindersController < ApplicationController
    ## turn off CSRF that won't render a null session
    skip_before_action :verify_authenticity_token
    before_action :getReminder, only: [:updateReminder, :deleteReminder, :showReminder]    

    ##get
    def getReminders
        reminder = Reminder.all        
        if reminder
            render json: reminder, status: :ok
        else
            render json: {msg: "Reminder Empty" }, status: :unprocessable_entity
        end
    end

    #get count of reminders in db
    def getRemindersCount
        reminder = Reminder.count()        
        if reminder
            render json: reminder, status: :ok
        else
            render json: {msg: "Reminder Empty" }, status: :unprocessable_entity
        end
    end

    #show
    def showReminder
        if @reminder
            render json: @reminder, status: :ok      
        else
            render json: {msg:"Reminder not found"}, status: :unprocessable_entity
        end
    end    

    ##post
    def addReminder
        reminder = Reminder.new(reminderparams)

        if reminder.save()
            render json: reminder, status: :ok
        else
            render json: {msg: "Reminder not added", error: reminder.errors }, status: :unprocessable_entity
        end

    end

    ##put
    def updateReminder
        if @reminder
            if @reminder.update(reminderparams)
                render json: @reminder, status: :ok
            else
                render json: {msg:"Update Failed"}, status: :unprocessable_entity
            end
        else
            render json: {msg:"Reminder not found"}, status: :unprocessable_entity
        end
    end

    ##delete
    def deleteReminder
        if @reminder
            if @reminder.destroy()
                render json: {msg: "Reminder Deleted"}, status: :ok
            else
                render json: {msg:"Delete Failed"}, status: :unprocessable_entity
            end
        else
            render json: {msg:"Reminder not found"}, status: :unprocessable_entity
        end
    end

    ##private params
    private

    #enter params
    def reminderparams
        params.permit(:rem_id, :rem_init_date, :rem_description, :rem_active);
    end

    def getReminder
        @reminder = Reminder.find(params[:id])
    end
end
