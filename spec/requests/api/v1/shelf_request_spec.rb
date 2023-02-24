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

  it 'can get all the shelves and ferns associated with a user' do
    user = create(:user)
    shelf = create(:shelf, user_id: user.id)
    ferns = create_list(:fern, 4, shelf_id: shelf.id)

    get api_v1_user_shelf_ferns_path(user.id, shelf.id)

    expect(response).to be_successful

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data]).to be_a(Array)
    
    shelves_response = parsed_response[:data]

    expected_shelf_names = ['Friends', 'Family', 'Romantic', 'Business', shelf.name]

    shelves_response.each_with_index do |shelf, i|
      expect(shelf).to have_key(:id)
      expect(shelf[:id]).to be_a(String)
      
      expect(shelf).to have_key(:type)
      expect(shelf[:type]).to eq("shelf")
      
      expect(shelf).to have_key(:attributes)
      expect(shelf[:attributes]).to have_key(:name)
      expect(shelf[:attributes][:name]).to eq(expected_shelf_names[i])

      expect(shelf).to have_key(:relationships)

      expect(shelf[:relationships]).to have_key(:user)
      expect(shelf[:relationships][:user][:data]).to be_a(Hash)
      expect(shelf[:relationships][:user][:data][:id]).to eq(user.id.to_s)
      expect(shelf[:relationships][:user][:data][:type]).to eq("user")

      expect(shelf[:relationships]).to have_key(:ferns)

      related_ferns = shelf[:relationships][:ferns][:data]

      expect(related_ferns).to be_an(Array)

      if i < 4
        expect(related_ferns).to be_empty # default shelves have no ferns
      elsif i == 4
        related_ferns.each_with_index do |fern, i|
          expect(fern[:id]).to eq(ferns[i].id.to_s)
          expect(fern[:type]).to eq("fern")
        end
      end
    end

    ferns_response = parsed_response[:included]

    expect(ferns_response).to be_an(Array)

    ferns_response.each_with_index do |fern, i|
      expect(fern).to have_key(:id)
      expect(fern[:id]).to eq(ferns[i].id.to_s)

      expect(fern).to have_key(:type)
      expect(fern[:type]).to eq("fern")

      expect(fern).to have_key(:attributes)

      expect(fern[:attributes]).to have_key(:name)
      expect(fern[:attributes][:name]).to eq(ferns[i].name)

      expect(fern[:attributes]).to have_key(:health)
      expect(fern[:attributes][:health]).to eq(ferns[i].health)

      expect(fern[:attributes]).to have_key(:preferred_contact_method)
      expect(fern[:attributes][:preferred_contact_method]).to eq(ferns[i].preferred_contact_method)

      expect(fern).to have_key(:relationships)

      expect(fern[:relationships]).to have_key(:shelf)
      expect(fern[:relationships][:shelf][:data]).to be_a(Hash)
      expect(fern[:relationships][:shelf][:data][:id]).to eq(shelf.id.to_s)
      expect(fern[:relationships][:shelf][:data][:type]).to eq("shelf")
    end
  end
end