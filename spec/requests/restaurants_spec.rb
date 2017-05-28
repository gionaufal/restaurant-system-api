require 'rails_helper'

describe 'Restaurants API', type: :request do

  let!(:restaurants)  { create_list(:restaurant, 5) }
  let(:restaurant_id) { restaurants.first.id }

  describe 'GET /restaurants' do
    before { get '/restaurants' }

    it 'returns restaurants' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'is successfull' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /restaurant/:id' do
    before { get "/restaurants/#{restaurant_id}" }

    context 'successfully' do
      it 'returns status code 200' do
        expect(response.status).to eq(200)
      end

      it 'returns the restaurant' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(restaurant_id)
      end
    end

    context 'trying to get non existing record' do
      let(:restaurant_id) { 42 }

      it 'returns 404' do
        expect(response.status).to eq(404)
      end

      it 'returns a message' do
        expect(response.body).to match(/Couldn't find Restaurant/)
      end
    end
  end

  describe 'POST /restaurants' do
    let(:valid_attr) { { name: 'Big Kahuna' } }

    context 'with valid attributes' do

      before { post '/restaurants', params: valid_attr }

      it 'creates a restaurant' do
        expect(json['name']).to eq('Big Kahuna')
      end

      it 'returns the right status' do
        expect(response.status).to eq(201)
      end
    end

    context 'without name attribute' do

      before { post '/restaurants', params: {} }

      it 'returns status 422' do
        expect(response.status).to eq(422)
        expect(response.body).to match(/Name não pode ficar em branco/)
      end
    end
  end

  describe 'PUT /restaurants/:id' do
    let(:valid_attr) { { name: 'Los Pollos Hermanos' } }

    context 'when the restaurant exists'do
      before { put "/restaurants/#{restaurant_id}", params: valid_attr }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns 204' do
        expect(response.status).to eq(204)
      end
    end
  end

  describe 'DELETE /restaurants/:id' do
    before { delete "/restaurants/#{restaurant_id}" }

    it 'returns 204' do
      expect(response.status).to eq(204)
    end
  end
end
