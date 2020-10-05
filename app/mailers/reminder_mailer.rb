class ReminderMailer < ApplicationMailer

  def reminder(user, reminder)
    @reminder = reminder

    mail({to: user.email, subject: "#{reminder.title}"})
  end
end
