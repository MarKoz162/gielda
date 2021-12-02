class UserStockSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :stock_id,:quantity
end
