require 'rails_helper'

describe 'Dishes API', type: :request do

  let(:restaurant)    { create(:restaurant) }
  let(:restaurant_id) { restaurant.id }
  let!(:dishes)       { create_list(:dish, 15, restaurant: restaurant) }
  let(:dish_id)       { dishes.first.id }

  describe 'GET /restaurants/:restaurant_id/dishes' do
    before { get "/restaurants/#{restaurant_id}/dishes" }

    context 'when restaurant exists' do
      it 'returns dishes' do
        expect(json.size).to eq(15)
      end

      it 'is successfull' do
        expect(response.status).to eq(200)
      end
    end

    context 'when restaurant doesn\t exist' do
      let(:restaurant_id) { 42 }

      it 'returns 404' do
        expect(response.status).to eq(404)
      end

      it 'returns a message' do
        expect(response.body).to match(/Couldn't find Restaurant/)
      end
    end
  end

  describe 'GET /restaurants/:restaurant_id/dishes/:id' do
    before { get "/restaurants/#{restaurant_id}/dishes/#{dish_id}" }

    context 'successfully' do
      it 'returns status code 200' do
        expect(response.status).to eq(200)
      end

      it 'returns the dis' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(dish_id)
      end
    end

    context 'trying to get non existing record' do
      let(:dish_id) { 42 }

      it 'returns 404' do
        expect(response.status).to eq(404)
      end

      it 'returns a message' do
        expect(response.body).to match(/Couldn't find Dish/)
      end
    end
  end

  describe 'POST /restaurants/:restaurant_id/dishes' do
    let(:valid_attr) { { dish: 'Burger', price: 25.5 } }

    context 'with valid attributes' do

      before { post "/restaurants/#{restaurant_id}/dishes", params: valid_attr }

      it 'creates a dish' do
        expect(json['dish']).to eq('Burger')
        expect(json['price']).to eq(25.5)
      end

      it 'returns the right status' do
        expect(response.status).to eq(201)
      end
    end

    context 'without price attribute' do

      before do
        post "/restaurants/#{restaurant_id}/dishes", params: { name: 'Burger' }
      end

      it 'returns status 422' do
        expect(response.status).to eq(422)
        expect(response.body).to match(/Price não pode ficar em branco/)
      end
    end
  end

  describe 'PUT /restaurants/:restaurant_id/dishes/:dish_id' do
    let(:valid_attr) { { price: 20.75 } }
    before do
      put "/restaurants/#{restaurant_id}/dishes/#{dish_id}",
        params: valid_attr
    end

    context 'when the dish exists'do

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns 204' do
        expect(response.status).to eq(204)
      end
    end

    context 'when the dish doesn\'t exist' do
      let(:dish_id) { 0 }

      it 'returns 404 and a message' do
        expect(response.status).to eq(404)
        expect(response.body).to match(/Couldn't find Dish/)
      end
    end
  end

  describe 'DELETE /restaurants/:restaurant_id/dishes/:dish_id' do
    before { delete "/restaurants/#{restaurant_id}/dishes/#{dish_id}" }

    it 'returns 204' do
      expect(response.status).to eq(204)
    end
  end
end
