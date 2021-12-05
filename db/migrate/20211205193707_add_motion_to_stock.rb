class AddMotionToStock < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :motion, :integer, default: 0, null: false
  end
end
