require 'rails_helper'

RSpec.describe "Fern" do
  it 'should have a default health of 6' do
    user = create(:user)
    @fern = create(:fern, user_id: user.id)
    expect(@fern.health).to eq(6)
  end


end