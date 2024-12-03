require 'rails_helper'

RSpec.describe Api::V1::ETransportationsController, type: :controller do
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
  let!(:e_transportation) { FactoryBot.create(:e_transportation) }

  describe 'GET #index' do
    it 'returns a list of e_transportations' do
      get :index
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)
      expect(assigns(:e_transportations)).to be_present
    end
  end

  describe 'GET #show' do
    it 'returns the e_transportation' do
      get :show, params: { id: e_transportation.id }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(e_transportation.id)
    end

    it 'returns 404 when not found' do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('ETransportation not found')
    end
  end

  describe 'POST #create' do
    let(:valid_attributes_1) do
      {
        transportation_type: :e_bike,
        sensor_type: :medium,
        owner_id: 31,
        in_zone: true,
        lost_sensor: false
      }
    end

    it 'creates a new e_transportation' do
      post :create, params: { e_transportation: valid_attributes_1 }

      expect(assigns(:e_transportation)).to be_present
      expect(response).to have_http_status(:created)
    end

    it 'does not create e_transportation with invalid data' do
      post :create, params: { e_transportation: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include("Transportation type can't be blank")
    end

    it 'does not create duplicate transportation' do
      post :create, params: { e_transportation: valid_attributes }
      post :create, params: { e_transportation: valid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include('Transportation with the same type, sensor, and owner already exists.')
    end
  end

  describe 'PATCH #update' do
    it 'updates the e_transportation with valid data' do
      patch :update, params: { id: e_transportation.id, e_transportation: valid_attributes }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['transportation_type']).to eq('e_bike')
    end

    it 'returns 422 when update fails' do
      patch :update, params: { id: e_transportation.id, e_transportation: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include("Transportation type can't be blank")
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the e_transportation' do
      expect {
        delete :destroy, params: { id: e_transportation.id }
      }.to change(ETransportation, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 404 if not found' do
      delete :destroy, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #count' do
    let!(:e_transportation_1) { FactoryBot.create(:e_transportation, transportation_type: :e_bike, owner_id: 4, sensor_type: :medium, in_zone: false) }
    let!(:e_transportation_2) { FactoryBot.create(:e_transportation, transportation_type: :e_bike, owner_id: 5, sensor_type: :small, in_zone: false) }
    let!(:e_transportation_3) { FactoryBot.create(:e_transportation, transportation_type: :e_scooter, owner_id: 6, sensor_type: :big, in_zone: true) }
    let!(:e_transportation_4) { FactoryBot.create(:e_transportation, transportation_type: :e_bike, owner_id: 7, sensor_type: :medium, in_zone: false) }

    it 'returns the correct count of e_transportations by transportation type and sensor type where in_zone is false' do
      get :count

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)

      # Ensure the count is correct for each transportation type and sensor type
      expect(json_response).to eq({"[\"e_bike\", \"small\"]"=>1, "[\"e_bike\", \"medium\"]"=>2})
    end
  end
end
