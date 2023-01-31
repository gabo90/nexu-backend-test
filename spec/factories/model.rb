# frozen_string_literal: true

FactoryBot.define do
  factory :model, class: 'Model' do
    name { Faker::Name.unique.name }
    average_price { Faker::Number.within(range: 100_000..999_999) }
    brand { association :brand }
  end
end
