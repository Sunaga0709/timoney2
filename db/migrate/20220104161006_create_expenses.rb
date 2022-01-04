class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :amount
      t.datetime :date
      t.text :memo
      t.integer :expense_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
