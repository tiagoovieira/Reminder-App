class Reminder < ApplicationRecord
  validates_presence_of :title, :description, :remind_at
  belongs_to :user

  scope :reminding_today, -> { where(remind_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day) }
end
