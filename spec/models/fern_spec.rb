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

  it 'has a method to update the ferns health based on an input rating' do
    user = create(:user)
    shelf = create(:shelf, user_id: user.id)
    fern = create(:fern, shelf_id: shelf.id)
    
    expect(fern.health).to eq(6)
    fern.message_update(-2)
    expect(fern.health).to eq(5)
    fern.message_update(+0.1)
    expect(fern.health).to eq(6)
  end

  it 'has a method to update ferns health that will not go below 0' do
    user = create(:user)
    shelf = create(:shelf, user_id: user.id)
    fern = create(:fern, shelf_id: shelf.id, health: 1)

    fern.message_update(-1)
    expect(fern.health).to eq(0)
    fern.message_update(-34)
    expect(fern.health).to eq(0)
  end

  it 'has a method to update fern health that will not go over 10' do
    user = create(:user)
    shelf = create(:shelf, user_id: user.id)
    fern = create(:fern, shelf_id: shelf.id, health: 9)

    fern.message_update(4)
    expect(fern.health).to eq(10)
    fern.message_update(2)
    expect(fern.health).to eq(10)
  end


end