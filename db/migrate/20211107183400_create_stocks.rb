class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :name, null: false
      t.integer :quantity, default: 1000, null: false
      t.decimal :purchase_price, null: false, default: 100
      t.decimal :sold_price, null: false, default: 80

      t.timestamps
    end
  end
end
