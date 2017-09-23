require 'rails_helper'

RSpec.describe Player, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  # Association test
  # ensure an item record belongs to a single game record
  it { should belong_to(:game) }

  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
  
  # ensure column score is present before saving
  it { should validate_presence_of(:score) }

end
