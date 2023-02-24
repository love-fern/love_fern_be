require 'rails_helper'

RSpec.describe "ferns API endpoints" do
  it 'sends a list of all a users ferns' do
    user1 = create(:user)
    shelf1 = create(:shelf, user_id: user1.id)
    fern1 = create(:fern, shelf_id: shelf1.id, preferred_contact_method: "text")
    fern2 = create(:fern, shelf_id: shelf1.id, preferred_contact_method: "text")
    fern3 = create(:fern, shelf_id: shelf1.id, preferred_contact_method: "text")

    get api_v1_user_ferns_path(user1.id)
    expect(response).to be_successful
    ferns_hash = JSON.parse(response.body, symbolize_names: true)
    expect(ferns_hash).to have_key(:data)
    expect(ferns_hash[:data]).to be_a(Array)
    fern_data = ferns_hash[:data]

    fern_data.each do |fern|
      expect(fern).to have_key(:id)
      expect(fern[:id]).to be_a(String)

      expect(fern).to have_key(:type)
      expect(fern[:type]).to be_a(String)

      expect(fern[:attributes]).to have_key(:name)
      expect(fern[:attributes][:name]).to be_a(String)

      expect(fern[:attributes]).to have_key(:health)
      expect(fern[:attributes][:health]).to be_a(Integer)

      expect(fern[:attributes]).to have_key(:shelf_id)
      expect(fern[:attributes][:shelf_id]).to be_a(Integer)
    end
  end

  it 'can send the information of a single fern' do
    user1 = create(:user)
    shelf1 = create(:shelf, user_id: user1.id)
    fern1 = create(:fern, shelf_id: shelf1.id, preferred_contact_method: "text")
    fern2 = create(:fern, shelf_id: shelf1.id, preferred_contact_method: "text")
    fern3 = create(:fern, shelf_id: shelf1.id, preferred_contact_method: "text")

    get api_v1_user_fern_path(user1, fern1)

    expect(response).to be_successful

    fern_hash = JSON.parse(response.body, symbolize_names: true)
    expect(fern_hash).to have_key(:data)
    expect(fern_hash[:data]).to be_a(Hash)

    fern_data = fern_hash[:data]

    expect(fern_data).to have_key(:id)
    expect(fern_data[:id]).to be_a(String)
    
    expect(fern_data).to have_key(:type)
    expect(fern_data[:type]).to be_a(String)

    expect(fern_data).to have_key(:attributes)
    expect(fern_data[:attributes]).to be_a(Hash)

    expect(fern_data[:attributes]).to have_key(:name)
    expect(fern_data[:attributes][:name]).to be_a(String)

    expect(fern_data[:attributes]).to have_key(:health)
    expect(fern_data[:attributes][:health]).to be_a(Integer)

    expect(fern_data[:attributes]).to have_key(:shelf_id)
    expect(fern_data[:attributes][:shelf_id]).to be_a(Integer)
  end

  it 'can ceate a new fern' do
    user1 = create(:user)
    shelf1 = create(:shelf, user_id: user1.id)
    
    fern_params = ({
      name: 'The Big Pepperoni',
      health: 6,
      preferred_contact_method: "text",
      shelf_id: shelf1.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users/#{user1.id}/ferns", headers: headers, params: JSON.generate(fern_params)
    created_fern = Fern.last

    expect(response).to be_successful
    expect(created_fern.name).to eq("The Big Pepperoni")
    expect(created_fern.health).to eq(6)
    expect(created_fern.shelf_id).to eq(shelf1.id)
  end

  it 'can update an existing fern' do
    user = create(:user)
    shelf = create(:shelf, user_id: user.id)
    shelf2 = create(:shelf, user_id: user.id)
    fern = create(:fern, 
                  shelf_id: shelf.id,
                  preferred_contact_method: "email")
    fern_id = fern.id

    fern_update_params = {shelf_id: shelf2.id,
                          name: "Fernilicious",
                          preferred_contact_method: "Don't"}
    headers = { 'CONTENT_TYPE' => 'application/json' }
    patch api_v1_user_fern_path(user.id, fern_id), headers: headers, params: JSON.generate(fern_update_params)

    updated_fern = Fern.find_by(id: fern_id)
    expect(response).to be_successful
    expect(updated_fern.shelf_id).to eq(shelf2.id)
    expect(updated_fern.name).to eq("Fernilicious")
    expect(updated_fern.preferred_contact_method).to eq("Don't")
  end

  it 'can delete a fern from the database' do
    user = create(:user)
    shelf = create(:shelf, user_id: user.id)
    fern = create(:fern, shelf_id: shelf.id)

    expect(Fern.find_by(id: fern.id)).to eq(fern)

    delete api_v1_user_fern_path(user.id, fern.id)

    expect(response).to be_successful
    expect{ Fern.find(fern.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end