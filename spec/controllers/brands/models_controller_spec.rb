require 'rails_helper'

RSpec.describe Brands::ModelsController, type: :controller do
  describe 'Test Brands Models controller' do
    let(:brand) { create(:brand) }
    let(:brand2) { create(:brand) }
    let!(:models) { create_list(:model, 3, brand: brand) }
    let!(:models2) { create_list(:model, 5, brand: brand2) }

    context 'success' do
      it 'should return a list of models associated with a brand' do
        get(:index, params: { brand_id: brand.id })
        json_data = JSON.parse(response.body)['data']

        expect(response.status).to eq(200)
        expect(json_data.size).to be(3)
        expect(json_data.map { _1['id'].to_i }.sort).to eq(brand.models.pluck(:id).sort)
      end

      it 'should return a full created model associated with a brand' do
        model_name = Faker::Vehicle.unique.model
        post(:create, params: { brand_id: brand.id, model: { name: model_name, average_price: 100_001 } })

        expect(response.status).to eq(201)
        expect(brand.models.count).to be(4)
        expect(brand.models.last.name).to eq(model_name)
      end

      it 'should return a partial created model associated with a brand' do
        model_name = Faker::Vehicle.unique.model
        post(:create, params: { brand_id: brand.id, model: { name: model_name } })

        expect(response.status).to eq(201)
        expect(brand.models.last.name).to eq(model_name)
        expect(brand.models.last.average_price).to be_falsy
      end
    end

    context 'fail' do
      it 'should return an error because the brand does not exist' do
        get(:index, params: { brand_id: 100_000 })
        json_data = JSON.parse(response.body)['errors']

        expect(response.status).to eq(404)
        expect(json_data.first['detail']).to eq('The Brand does not exist.')
      end

      it 'should return an error because the model already exists for that brand' do
        model_name = brand2.models.first.name
        post(:create, params: { brand_id: brand2.id, model: { name: model_name } })
        json_data = JSON.parse(response.body)['errors']

        expect(response.status).to eq(400)
        expect(json_data.first['detail']).to eq('The model alreay exists.')
      end

      it 'should return an error because the average_price is not greater than 100_000' do
        post(:create, params: { brand_id: brand.id, model: { name: Faker::Vehicle.unique.model, average_price: 100_000 } })
        json_data = JSON.parse(response.body)['errors']

        expect(response.status).to eq(422)
        expect(json_data['average_price'].first).to eq('must be greater than 100000')
      end
    end
  end
end
