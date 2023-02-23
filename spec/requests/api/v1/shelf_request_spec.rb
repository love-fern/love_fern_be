require 'rails_helper'

RSpec.describe "shelves API endpoints" do
  it 'can create a shelf' do
    user1 = create(:user)

    shelf_params = ({
      name: 'All the Baddies in my life',
      user_id: user1.id
    })

    headers = {"CONTENT_TYPE" => "application/json"}

    post api_v1_user_shelves_path(user1), headers: headers, params: JSON.generate(shelf: shelf_params)
    created_shelf = Shelf.last

    expect(response).to be_successful
    expect(created_shelf.name).to eq("All the Baddies in my life")
    expect(created_shelf.user_id).to eq(user1.id)
  end

  it 'can update an existing shelf' do
    user1 = create(:user)
    shelf1 = create(:shelf, 
                    user_id: user1.id,
                    name: "Someone Special")
    shelf_id = shelf1.id

    shelf_params = ({
      name: 'All the Baddies in my life',
      user_id: user1.id
    })

    headers = {"CONTENT_TYPE" => "application/json"}
    patch api_v1_user_shelf_path(user1, shelf1), headers: headers, params: JSON.generate(shelf: shelf_params)
    
    updated_shelf = Shelf.find_by(id: shelf_id)
    expect(response).to be_successful
    expect(updated_shelf.name).to eq("All the Baddies in my life")
    expect(updated_shelf.user_id).to eq(user1.id)
  end

  it 'can delete a shelf from the database' do
    user1 = create(:user)
    shelf1 = create(:shelf, user_id: user1.id)

    expect(Shelf.find_by(id: shelf1.id)).to eq(shelf1)

    delete "/api/v1/users/#{user1.id}/shelves/#{shelf1.id}"

    expect(response).to be_successful
    expect{ Shelf.find(shelf1.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end