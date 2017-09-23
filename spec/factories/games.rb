FactoryGirl.define do
  factory :game do
    lane { Faker::Number.number(7) }
  end
end
