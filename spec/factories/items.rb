FactoryBot.define do
  factory :item do
    name                          { Faker::Book.title }
    explain                       { Faker::Lorem.sentence }
    price                         { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id                   { Faker::Number.between(from: 2, to: 11) }
    condition_id                  { Faker::Number.between(from: 2, to: 7) }
    shipping_cost_id              { Faker::Number.between(from: 2, to: 3) }
    prefecture_id                 { Faker::Number.between(from: 2, to: 48) }
    estimated_shipping_date_id    { Faker::Number.between(from: 2, to: 4) }

    association :user

    # テスト画像
    after(:build) do |item|
      item.image.attach(io: File.open('spec/images/test_pic.png'), filename: 'test_pic.png', content_type: 'image/png')
    end
  end
end
