# frozen_string_literal: true

FactoryBot.define do
  factory :brand, class: 'Brand' do
    name { Faker::Name.unique.name }
  end
end
