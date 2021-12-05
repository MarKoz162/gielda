class StockSerializer < ActiveModel::Serializer
  attributes :id, :name, :quantity, :purchase_price, :sold_price, :motion
  
end
