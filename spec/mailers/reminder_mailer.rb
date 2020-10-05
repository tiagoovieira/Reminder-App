# frozen_string_literal: true

require 'rails_helper'

describe ReminderMailer do
  let(:user) { User.create(email: 'a@a.pt', password: 123123123) }
  let!(:reminder) { Reminder.create(title: 'a', description: 'b', remind_at: Time.now) }

  describe '#contact_email' do
    subject { ReminderMailer.reminder(user, reminder) }
    it { is_expected.to deliver_to(user.email) }
  end
end
