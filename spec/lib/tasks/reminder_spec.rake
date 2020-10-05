# frozen_string_literal: true

require 'rails_helper'

describe 'reminder' do
  include_context 'rake'

  describe 'reminders:send_reminders', sidekiq: :inline do
    before do
      allow(Batches::SendRemainderWorker).to receive(:perform_async)
    end

    it 'calls the batch worker' do
      subject.invoke
      expect(Batches::SendRemainderWorker).to have_received(:perform_async)
    end
  end
end
