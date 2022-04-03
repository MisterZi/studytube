class StockSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :bearer
end
