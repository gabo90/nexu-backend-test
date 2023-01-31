# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :models

  validates_uniqueness_of :name
  validates_presence_of :name
end
