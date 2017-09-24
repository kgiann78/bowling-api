class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :score, :created_at, :updated_at

  has_many :frames
end
