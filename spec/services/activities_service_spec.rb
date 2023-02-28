require 'rails_helper'

RSpec.describe ActivitiesService, type: :service do
  context 'class methods' do
    it 'returns a random activity', :vcr do
      service = ActivitiesService.random_activity

      expect(service).to be_a(Hash)
      expect(service).to have_key(:activity)
      expect(service[:activity]).to be_a(String)
    end
  end
end
