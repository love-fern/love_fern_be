require 'rails_helper'

RSpec.describe 'activity API endpoint' do
  context 'requesting a random activity' do
   it 'sends a random activity using Bored API' do
      get api_v1_activities_path
      expect(response).to be_successful
      require 'pry'; binding.pry
      activity_hash = JSON.parse(response.body, symbolize_names: true)
      
    end
  end
end