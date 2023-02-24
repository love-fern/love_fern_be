require 'rails_helper'

RSpec.describe ActivitiesFacade, type: :facade do
  context 'call random Activity' do
    it 'random_activity' do
      expect(ActivitiesFacade.random_activity).to be_an(Activity)
    end
  end
end