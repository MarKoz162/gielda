class UserStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  validates :user, :stock, presence: true
  
  validates_uniqueness_of :user_id, scope: :stock_id
  validates_uniqueness_of :stock_id, scope: :user_id
end
