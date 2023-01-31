# frozen_string_literal: true

class Model < ApplicationRecord
  belongs_to :brand

  validates_presence_of :name
  validates :average_price, numericality: { greater_than: 100_000 }, allow_nil: true
end
