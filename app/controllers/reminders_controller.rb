class RemindersController < ApplicationController
  before_action :authenticate_user!

  def index
    @reminders = current_user.reminders.all
  end

  def new
    @reminder = current_user.reminders.new
  end

  def create
    @reminder = current_user.reminders.build(reminder_params)

    if @reminder.save
      redirect_to reminders_path, notice: 'Reminder created'
    else
      redirect_to reminders_path, notice: @reminder.errors.full_messages
    end
  end

  def edit
    @reminder = current_user.reminders.find(params[:id])
  end

  def update
    @reminder = current_user.reminders.find(params[:id])

    @reminder.assign_attributes(reminder_params)
    
    if @reminder.save
      redirect_to reminders_path, notice: 'Reminder updated'
    else
      redirect_to reminders_path, notice: @reminder.errors.full_messages
    end
  end

  def destroy
    @reminder = current_user.reminders.find(params[:id])

    if @reminder.destroy!
      redirect_to reminders_path, notice: 'Reminder deleted'
    else
      redirect_to reminders_path, notice: 'Error while deleting the reminder'
    end
  end

  private

  def reminder_params
    params.require(:reminder).permit(:title, :description, :remind_at, :recurrent)
  end
end
