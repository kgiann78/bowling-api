FactoryGirl.define do
  factory :player do
    name { Faker::StarWars.character }
    score { Faker::Number.number(10) }
    game_id nil
  end
end
