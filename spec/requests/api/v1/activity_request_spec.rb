require 'rails_helper'

RSpec.describe 'activity API endpoint' do
  context 'requesting a random activity' do
    it 'sends a random activity using Bored API', :vcr do
      get api_v1_activities_path, headers: { 'HTTP_FERN_KEY' => ENV['FERN_KEY'] }

      expect(response).to be_successful

      activity = JSON.parse(response.body, symbolize_names: true)

      expect(activity).to be_a(Hash)
      expect(activity).to have_key(:activity)
      expect(activity[:activity]).to be_a(String)
    end
  end
end
