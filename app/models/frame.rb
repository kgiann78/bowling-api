class Frame < ApplicationRecord
  belongs_to :player

  # validations
  validates_presence_of :number, :tries, :score

end
