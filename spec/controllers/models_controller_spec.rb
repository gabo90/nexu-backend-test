require 'rails_helper'

RSpec.describe ModelsController, type: :controller do
  describe 'Test Models controller' do
    let!(:models) do
      [100_001, 100_100, 200_300, 290_000, 301_345, 900_000].map do |average_price|
        create(:model, average_price: average_price)
      end
    end

    context 'return a list of models according to the query criteria' do
      it 'by greater and lower' do
        get(:index, params: { greater: 100_090, lower: 500_000 })
        json_data = JSON.parse(response.body)['data']

        expect(response.status).to eq(200)
        expect(json_data.size).to eq(4)
      end

      it 'by greater only' do
        get(:index, params: { greater: 200_500 })
        json_data = JSON.parse(response.body)['data']

        expect(response.status).to eq(200)
        expect(json_data.size).to eq(3)
      end

      it 'by lower only' do
        get(:index, params: { lower: 500_000 })
        json_data = JSON.parse(response.body)['data']

        expect(response.status).to eq(200)
        expect(json_data.size).to eq(5)
      end

      it 'without criteria' do
        get(:index)
        json_data = JSON.parse(response.body)['data']

        expect(response.status).to eq(200)
        expect(json_data.size).to eq(6)
      end
    end

    context 'update model by id' do
      it 'success' do
        selected_model = models.last
        put(:update, params: { id: models.last.id, model: { average_price: 500_000 } })
        json_data = JSON.parse(response.body)['data']

        expect(response.status).to eq(200)
        expect(selected_model.average_price).not_to eq(json_data['attributes']['average_price'])
        expect(json_data['attributes']['average_price']).to eq(500_000)
      end

      it 'fail' do
        put(:update, params: { id: models.last.id, model: { average_price: 100_000 } })
        json_data = JSON.parse(response.body)['errors']

        expect(response.status).to eq(422)
        expect(json_data['average_price'].first).to eq('must be greater than 100000')
      end
    end
  end
end
