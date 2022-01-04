class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.text :memo
      t.references :user, null: false, foreign_key: true
      t.references :work, foreign_key: true

      t.timestamps
    end
  end
end
