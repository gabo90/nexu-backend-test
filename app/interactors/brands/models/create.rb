# frozen_string_literal: true

class Brands::Models::Create
  include Interactor

  def call
    handle_error(error: 'The Brand does not exist.', status: 404) unless brand.present?
    handle_error(error: 'The model alreay exists.', status: 400) if already_exists?

    create_model!
  end

  private

  def brand
    @brand ||= Brand.find_by(id: context.brand_id)
  end

  def already_exists?
    Model.exists?(name: context.name, brand: brand)
  end

  def create_model!
    model = Model.create(name: context.name, average_price: context.average_price, brand: brand)
    handle_error(errors: model.errors, status: 422) if model.errors.any?

    context.model = model
  end

  def handle_error(params)
    return if context.failure?

    context.fail!(**params)
  end
end
