class Brands::ModelsController < ApplicationController
  # GET /brands/:brand_id/models
  before_action

  def index
    ctx = ::Brands::Models::Index.call(brand_id: params[:brand_id])

    return error_response(ctx) if ctx.failure?

    render json: ModelSerializer.new(ctx.models).serializable_hash
  end

  # POST /brands/:brand_id/models
  def create
    ctx = ::Brands::Models::Create.call({ **model_params, brand_id: params[:brand_id] })

    return error_response(ctx) if ctx.failure?

    render json: ModelSerializer.new(ctx.model).serializable_hash, status: :created
  end

  private

  # Only allow a list of trusted parameters through.
  def model_params
    params.require(:model).permit(%i[name average_price])
  end
end
