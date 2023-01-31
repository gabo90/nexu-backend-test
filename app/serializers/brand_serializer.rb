# frozen_string_literal: true

class BrandSerializer < ApplicationSerializer
  attributes :id, :name

  attribute :average_price do |brand|
    models_prices = brand.models.pluck(:average_price).compact
    models_prices.any? ? (models_prices.sum / models_prices.size) : 0
  end
end
