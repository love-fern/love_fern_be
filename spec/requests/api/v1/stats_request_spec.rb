require 'rails_helper'

RSpec.describe 'stats request' do
  describe 'index' do
    it 'returns fern health over time' do
      fern = create(:fern)
      10.times { fern.message_update(rand(-1.0..1.0).round(1)) }
      
      get api_v1_user_fern_stats_path(fern.user.google_id,fern.id), headers: { 'HTTP_FERN_KEY' => ENV['FERN_KEY'] }

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:id]).to be_a(String)
      expect(parsed_response[:data][:type]).to eq('fern')

      expect(parsed_response[:data][:attributes][:name]).to be_a(String)
      expect(parsed_response[:data][:attributes][:stats]).to be_an(Array)

      parsed_response[:data][:attributes][:stats].each do |stat|
        expect(stat).to be_a(Float)
      end
    end
  end
end