FactoryBot.define do
  factory :answer do
       text                     {'大丈夫です'}
       association :user
       association :question
  end
end
