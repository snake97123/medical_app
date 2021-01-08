FactoryBot.define do
  factory :user do
    nickname           { Faker::Name.initials(number: 2) }
    email              { Faker::Internet.free_email }
    phone_number       { Faker::Number.leading_zero_number(digits: 11) }
    password           { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end
