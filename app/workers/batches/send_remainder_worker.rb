class Batches::SendRemainderWorker
  include Sidekiq::Worker

  BATCH_SIZE = 100

  def perform
    Reminder.reminding_today.pluck(:id).each_slice(BATCH_SIZE) do |reminder_ids|
      SendRemainderWorker.perform_async(reminder_ids)
    end
  end
end
