# spec/requests/api/v1/e_transportations_spec.rb
require 'rails_helper'

RSpec.describe 'ETransportations API', type: :request do
  let!(:e_transportation) { create(:e_transportation) } # Assuming you have a factory for ETransportation
  let(:valid_attributes) do
    {
      transportation_type: :e_bike,
      sensor_type: :medium,
      owner_id: 1,
      in_zone: true,
      lost_sensor: false
    }
  end

  let(:invalid_attributes) do
    {
      transportation_type: nil,
      sensor_type: nil,
      owner_id: nil,
      in_zone: nil
    }
  end

  describe 'GET /api/v1/e_transportations' do
    it 'returns a list of e_transportations' do
      get '/api/v1/e_transportations'
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)
    end
  end

  describe 'GET /api/v1/e_transportations/:id' do
    it 'returns the requested e_transportation' do
      get "/api/v1/e_transportations/#{e_transportation.id}"
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(e_transportation.id)
    end

    it 'returns 404 if e_transportation not found' do
      get '/api/v1/e_transportations/9999'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /api/v1/e_transportations' do
    let(:valid_attributes_1) do
      {
        transportation_type: :e_bike,
        sensor_type: :medium,
        owner_id: 10,
        in_zone: true,
        lost_sensor: false
      }
    end

    it 'creates a new e_transportation with valid attributes' do
      expect {
        post '/api/v1/e_transportations', params: { e_transportation: valid_attributes_1 }
      }.to change(ETransportation, :count).by(1)
      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response['transportation_type']).to eq('e_bike')
    end

    it 'returns 422 with invalid attributes' do
      post '/api/v1/e_transportations', params: { e_transportation: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include("Transportation type can't be blank")
    end

    it 'returns error for duplicate transportation' do
      post '/api/v1/e_transportations', params: { e_transportation: valid_attributes }
      post '/api/v1/e_transportations', params: { e_transportation: valid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include('Transportation with the same type, sensor, and owner already exists.')
    end
  end

  describe 'PATCH /api/v1/e_transportations/:id' do
    it 'updates the e_transportation with valid attributes' do
      patch "/api/v1/e_transportations/#{e_transportation.id}", params: { e_transportation: valid_attributes }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['transportation_type']).to eq('e_bike')
    end

    it 'returns 422 when update fails' do
      patch "/api/v1/e_transportations/#{e_transportation.id}", params: { e_transportation: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include("Transportation type can't be blank")
    end
  end

  describe 'DELETE /api/v1/e_transportations/:id' do
    it 'deletes the e_transportation' do
      expect {
        delete "/api/v1/e_transportations/#{e_transportation.id}"
      }.to change(ETransportation, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 404 when the e_transportation is not found' do
      delete '/api/v1/e_transportations/9999'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /api/v1/count' do
    it 'returns the count of e_transportations in the zone' do
      get '/api/v1/count'
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Hash)
    end
  end
end
