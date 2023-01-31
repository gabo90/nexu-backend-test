class ModelsController < ApplicationController
  # GET /models
  def index
    ctx = Models::Index.call(filter_params)

    render json: ModelSerializer.new(ctx.models).serializable_hash
  end

  # PUT /models/:id
  def update
    ctx = Models::Update.call(**update_params, id: params[:id])

    return error_response(ctx) if ctx.failure?

    render json: ModelSerializer.new(ctx.model).serializable_hash, status: :ok
  end

  private

  # Only allow a list of trusted parameters through.
  def update_params
    params.require(:model).permit(%i[average_price])
  end

  def filter_params
    params.permit(%i[greater lower])
  end
end
