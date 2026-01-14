FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 5) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    family_name           { '佐藤' }
    first_name            { '太郎' }
    family_name_kana      { 'サトウ' }
    first_name_kana       { 'タロウ' }
    birthday              { Faker::Date.backward(days: 14) }
  end
end
