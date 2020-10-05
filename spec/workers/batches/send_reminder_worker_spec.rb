# frozen_string_literal: true

require 'rails_helper'

describe Batches::SendRemainderWorker, sidekiq: :inline do
  subject { described_class.new.perform }

  describe '#perform' do
    context 'when there are reminders to be sent' do
      let(:user) { User.create(email: 'a@a.pt', password: 123123123) }

      before do
        Reminder.create!(user_id: user.id, title: 'a', description: 'b', remind_at: Time.current, recurrent: true)
        allow(SendRemainderWorker).to receive(:perform_async)
      end

      it 'triggers the send reminder worker' do
        subject
        expect(SendRemainderWorker).to have_received(:perform_async)
      end
    end

    context 'when there are no reminders to be sent' do
      before do
        allow(SendRemainderWorker).to receive(:perform_async)
      end

      it 'does not triggers the send reminder worker' do
        subject
        expect(SendRemainderWorker).to_not have_received(:perform_async)
      end
    end
  end
end
