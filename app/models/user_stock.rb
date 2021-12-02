class UserStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  validates :user, :stock, presence: true
  
  validates_uniqueness_of :user_id, scope: :stock_id
  validates_uniqueness_of :stock_id, scope: :user_id
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  


end
