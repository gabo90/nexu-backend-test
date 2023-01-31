require 'rails_helper'

RSpec.describe BrandsController, type: :controller do

  describe 'Test Brands controller' do
    context 'success' do
      let(:brands) { create_list(:brand, 3) }
      let!(:models) { brands.map { create_list(:model, 3, brand: _1) } }

      it 'should return a list of brands with average price calculated' do
        get(:index)
        json_data = JSON.parse(response.body)['data']
        average_price = (Brand.first.models.pluck(:average_price).compact.sum / 3)

        expect(response.status).to eq(200)
        expect(json_data.size).to be(3)
        expect(json_data.first['attributes']['average_price']).to be(average_price)
      end

      it 'should return a created brand' do
        brand_name = Faker::Vehicle.unique.make
        post(:create, params: { brand: { name: brand_name } })
        json_data = JSON.parse(response.body)['data']

        expect(response.status).to eq(201)
        expect(Brand.count).to be(4)
        expect(Brand.last.name).to eq(json_data['attributes']['name'])
      end
    end

    context 'fail' do
      let(:brand_name) { Faker::Vehicle.unique.make }
      let!(:brand) { create(:brand, name: brand_name) }

      it 'should return an error' do
        post(:create, params: { brand: { name: brand_name } })
        json_data = JSON.parse(response.body)['errors']

        expect(response.status).to eq(422)
        expect(Brand.count).to be(1)
        expect(json_data['name'].first).to eq('has already been taken')
      end
    end
  end
end
