FactoryBot.define do
  factory :question do
      title                {'熱が出ました'}
      content              {'熱がでてさがらないです'}
      association :user
    end
end
