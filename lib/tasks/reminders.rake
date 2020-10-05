namespace :reminders do
  task send_reminders: :environment do
    Batches::SendRemainderWorker.perform_async
  end
end
