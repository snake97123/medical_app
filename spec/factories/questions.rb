FactoryBot.define do
  factory :question do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.sentence }
    association :user
  end
end
