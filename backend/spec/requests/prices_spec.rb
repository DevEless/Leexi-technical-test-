require 'rails_helper'

RSpec.describe 'Prices API', type: :request do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  describe 'POST /v1/prices' do
    it 'retourne les bons prix pour ai_meeting avec 20 licences' do
      post '/v1/prices',
           params: { number_of_licenses: 20, plan: 'ai_meeting', period: 'monthly' }.to_json,
           headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['prices']['monthly']).to eq(500) # 20 * 25
      expect(json['prices']['annually']).to eq(5400.0)
    end

    it 'retourne une erreur 400 si des params sont manquants' do
      post '/v1/prices',
           params: { plan: 'ai_meeting' }.to_json,
           headers: headers

      expect(response).to have_http_status(:bad_request)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Paramètres invalides')
    end

    it 'retourne une erreur 422 pour enterprise avec < 10 licences' do
      post '/v1/prices',
           params: { number_of_licenses: 5, plan: 'enterprise', period: 'monthly' }.to_json,
           headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Le plan Enterprise requiert au moins 10 licences')
    end

    it 'retourne une erreur pour un plan inconnu' do
      post '/v1/prices',
           params: { number_of_licenses: 10, plan: 'inconnu', period: 'monthly' }.to_json,
           headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Plan inconnu')
    end
  end
end
