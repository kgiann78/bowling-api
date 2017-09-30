FactoryGirl.define do
  factory :frame do
    number { Faker::Number.number(1) }
    tries { Faker::Number.number(2) }
    score { Faker::Number.number(0) }
    player_id nil
  end
end
