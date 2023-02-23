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
end