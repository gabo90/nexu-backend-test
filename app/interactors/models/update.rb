# frozen_string_literal: true

class Models::Update
  include Interactor

  def call
    handle_error(error: 'The Model does not exist.', status: 404) unless model.present?

    update_model!
  end

  private

  def model
    @model ||= Model.find_by(id: context.id)
  end

  def update_model!
    model.update(average_price: context.average_price)
    handle_error(errors: model.errors, status: 422) if model.errors.any?

    context.model = model.reload
  end

  def handle_error(params)
    return if context.failure?

    context.fail!(**params)
  end
end
