class Stock < ApplicationRecord
    validates :name, presence: true
    validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
    validates :purchase_price, presence: true
    validates :sold_price, presence: true
    
end