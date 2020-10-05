# frozen_string_literal: true 

require 'rails_helper'

describe SendRemainderWorker, sidekiq: :inline do
  let(:user) { User.create(email: 'a@a.pt', password: 123123123) }
  let!(:reminder_id) { Reminder.create!(user_id: user.id, title: 'a', description: 'b', remind_at: Time.current, recurrent: true) }
  let!(:reminder_id2) { Reminder.create!(user_id: user.id, title: 'a', description: 'b', remind_at: Time.current, recurrent: true) }

  describe '#perform' do
    context 'when there are reminders to be sent' do
      subject { described_class.new.perform([reminder_id, reminder_id2]) }
      let(:user) { User.create(email: 'a@a.pt', password: 123123123) }

      before do
        allow(ReminderMailer).to receive(:send)
      end

      it 'triggers the send reminder worker' do
        subject
        expect(ReminderMailer).to have_received(:send).at_least(2)
      end
    end

    context 'when there are no reminders to be sent' do
      subject { described_class.new.perform([]) }
      before do
        allow(ReminderMailer).to receive(:send)
      end

      it 'does not triggers the send reminder worker' do
        subject
        expect(ReminderMailer).to_not have_received(:send)
      end
    end
  end
end
