class BrandsController < ApplicationController
  # GET /brands
  def index
    brands = Brand.all

    render json: BrandSerializer.new(brands).serializable_hash
  end

  # POST /brands
  def create
    brand = Brand.new(brand_params)

    if brand.save
      render json: BrandSerializer.new(brand).serializable_hash, status: :created
    else
      error_response(errors: brand.errors, status: 422)
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def brand_params
    params.require(:brand).permit(:name)
  end
end
