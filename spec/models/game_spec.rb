require 'rails_helper'

RSpec.describe Game, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:players).dependent(:destroy) }
  # Validation tests
  # ensure columns lane are present before saving
  it { should validate_presence_of(:lane) }
end
