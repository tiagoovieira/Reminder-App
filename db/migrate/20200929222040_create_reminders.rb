class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.string :title
      t.text :description
      t.boolean :recurrent
      t.date :remind_at
      t.references :user
      t.timestamps
    end
  end
end
