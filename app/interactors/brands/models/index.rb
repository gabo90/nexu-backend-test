# frozen_string_literal: true

class Brands::Models::Index
  include Interactor

  def call
    handle_error(error: 'The Brand does not exist.', status: 404) unless brand.present?

    context.models = brand.models
  end

  private

  def brand
    @brand ||= Brand.find_by(id: context.brand_id)
  end

  def handle_error(params)
    eturn if context.failure?

    context.fail!(**params)
  end
end
