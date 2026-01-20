FactoryBot.define do
  factory :order_shipping_address do
    post_code             { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id         { Faker::Number.between(from: 2, to: 48) }
    municipality          { Faker::Address.city }
    street_address        { Faker::Address.street_address }
    building_name         { Faker::Lorem.word }
    phone_number          { Faker::Number.number(digits: 11).to_s }
    token                 { "tok_#{Faker::Alphanumeric.alphanumeric(number: 28)}" }
  end
end
