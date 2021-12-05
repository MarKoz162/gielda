class Stock < ApplicationRecord
    validates :name, presence: true
    validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
    validates :purchase_price, presence: true
    validates :sold_price, presence: true
    has_many :user_stocks
    
    def calculate_quantity(quantity)
      update_column :quantity, (self.quantity + quantity)
    end

    def calculate_price(motion)
      update_column :motion, (self.motion + motion)
      inf = Float::INFINITY
      case self.motion
      when -inf..-50 then
        change_price(-3)
        update_column :motion, 0
      when -50..-20 then
        change_price(-2)
        update_column :motion, 0
      when -20..-10 then
        change_price(-1)
        update_column :motion, 0
      when 10..20 then
        change_price(1)
        update_column :motion, 0
      when 20..50 then
        change_price(2)
        update_column :motion, 0
      when 50..inf then
        change_price(3)
        update_column :motion, 0
      end
    end

    def change_price(number)
      case number
      when 1 then
        update_column :purchase_price, (self.purchase_price * 1.05)
        update_column :sold_price, (self.sold_price * 1.05)
      when 2 then
        update_column :purchase_price, (self.purchase_price * 1.10)
        update_column :sold_price, (self.sold_price * 1.10)
      when 3 then
        update_column :purchase_price, (self.purchase_price * 1.20)
        update_column :sold_price, (self.sold_price * 1.20)
      when -1 then 
        update_column :purchase_price, (self.purchase_price * 0.95)
        update_column :sold_price, (self.sold_price * 0.95)
      when -2 then
        update_column :purchase_price, (self.purchase_price * 0.90)
        update_column :sold_price, (self.sold_price * 0.90)
      when -3 then
        update_column :purchase_price, (self.purchase_price * 0.80)
        update_column :sold_price, (self.sold_price * 0.80)
      end
    end
end
