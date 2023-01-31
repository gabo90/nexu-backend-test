# frozen_string_literal: true

class Models::Index
  include Interactor

  def call
    context.models = Model.where(query)
  end

  private

  def query
    if context.greater.present? && context.lower.present?
      ['average_price between ? and ?', context.greater, context.lower]
    elsif context.lower.present?
      { average_price: (..context.lower) }
    else
      { average_price: (context.greater..) }
    end
  end
end
