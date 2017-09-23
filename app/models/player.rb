class Player < ApplicationRecord
  belongs_to :game
  # model association
  has_many :frames, dependent: :destroy

  # validations
  validates_presence_of :name, :score
end
