class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.string :name
      t.integer :wage
      t.integer :wage_type
      t.integer :carfare, default: 0
      t.integer :carfare_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
