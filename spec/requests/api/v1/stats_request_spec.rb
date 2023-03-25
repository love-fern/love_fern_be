require 'rails_helper'

RSpec.describe 'stats request' do
  describe 'index' do
    it 'returns fern health history with all interactions' do
      fern = create(:fern)
      10.times { fern.message_update(rand(-1.0..1.0).round(1)) }
      
      get api_v1_user_fern_stats_path(fern.user.google_id,fern.id), headers: { 'HTTP_FERN_KEY' => ENV['FERN_KEY'] }

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:id]).to be_a(String)
      expect(parsed_response[:data][:type]).to eq('fern')

      expect(parsed_response[:data][:attributes][:name]).to be_a(String)

      included = parsed_response[:included]

      expect(included).to be_an(Array)

      interactions = included.select { |x| x[:type] == 'interaction' }

      interactions.each do |interaction|
        expect(interaction[:id]).to be_a(String)
        expect(interaction[:type]).to eq('interaction')
        expect(interaction[:attributes][:evaluation]).to be_a(Float)
      end

      expect(interactions.count).to eq(fern.interactions.count)
    end
  end
end