class Game < ApplicationRecord
  # model association
  has_many :players, dependent: :destroy

  # validations
  validates_presence_of :lane
end
