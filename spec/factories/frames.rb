FactoryGirl.define do
  factory :frame do
    number { Faker::Number.number(1) }
    score { Faker::Number.number(10) }
    player_id nil
  end
end
