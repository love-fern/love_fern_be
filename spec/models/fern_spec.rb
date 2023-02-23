require 'rails_helper'

RSpec.describe Fern do
  describe "relationships" do
    it { should belong_to(:shelf) }
  end

  it 'should have a default health of 6' do
    user = create(:user)
    shelf = create(:shelf, user_id: user.id)

    @fern = create(:fern, shelf_id: shelf.id)
    expect(@fern.health).to eq(6)
  end


end