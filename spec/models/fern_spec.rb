require 'rails_helper'

RSpec.describe "Fern" do
  it 'should have a default health of 6' do
    @fern = create(:fern)
    expect(@fern.health).to eq(6)
  end


end