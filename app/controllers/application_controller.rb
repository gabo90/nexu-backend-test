class ApplicationController < ActionController::API
  private

  def error_response(context)
    errors = [{ detail: context[:error] }] if context[:error].present?

    render json: {
      errors: errors || context[:errors]
    }, status: context[:status]
  end
end
