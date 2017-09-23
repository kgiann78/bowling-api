require 'rails_helper'

RSpec.describe Frame, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # Association test
  # ensure an item record belongs to a single player record
  it { should belong_to(:player) }

  # Validation test
  # ensure column number is present before saving
  it { should validate_presence_of(:number) }

  # ensure column tries is present before saving
  it { should validate_presence_of(:tries) }

  # ensure column score is present before saving
  it { should validate_presence_of(:score) }
end
