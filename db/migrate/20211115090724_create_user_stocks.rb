class CreateUserStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_stocks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end
