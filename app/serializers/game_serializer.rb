class GameSerializer < ActiveModel::Serializer
  attributes :id, :lane, :created_at, :updated_at

  has_many :players
end
