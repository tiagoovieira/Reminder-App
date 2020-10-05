class SendRemainderWorker
  include Sidekiq::Worker
  
  def perform(reminder_ids)
    Reminder.where(id: reminder_ids).reminding_today.includes(:user).find_each do |reminder|
      user = reminder.user
      ReminderMailer.send(user, reminder)

      reminder.update(remind_at: reminder.remind_at + 1.month) if reminder.recurrent
    end
  end
end
