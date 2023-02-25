require 'rails_helper'

RSpec.describe "ferns API endpoints" do
  describe "happy path testing" do
    it 'sends a list of all a users ferns' do
      user = create(:user)
      shelf = create(:shelf, user_id: user.id)
      ferns = create_list(:fern, 3, shelf_id: shelf.id)

      get api_v1_user_ferns_path(user.id), headers: {"HTTP_FERN_KEY" => ENV["FErn_key"]}

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to have_key(:data)
      expect(parsed_response[:data]).to be_a(Array)

      ferns_response = parsed_response[:data]

      ferns_response.each_with_index do |fern, i|
        expect(fern).to have_key(:id)
        expect(fern[:id]).to be_a(String)
        expect(fern[:id]).to eq(ferns[i].id.to_s)

        expect(fern).to have_key(:type)
        expect(fern[:type]).to be_a(String)
        expect(fern[:type]).to eq("fern")

        expect(fern[:attributes]).to have_key(:name)
        expect(fern[:attributes][:name]).to be_a(String)
        expect(fern[:attributes][:name]).to eq(ferns[i].name)

        expect(fern[:attributes]).to have_key(:health)
        expect(fern[:attributes][:health]).to be_a(Integer)
        expect(fern[:attributes][:health]).to eq(ferns[i].health)

        expect(fern[:attributes]).to have_key(:preferred_contact_method)
        expect(fern[:attributes][:preferred_contact_method]).to be_a(String)
        expect(fern[:attributes][:preferred_contact_method]).to eq(ferns[i].preferred_contact_method)

        expect(fern).to have_key(:relationships)

        expect(fern[:relationships]).to have_key(:shelf)
        expect(fern[:relationships][:shelf][:data]).to be_a(Hash)
        expect(fern[:relationships][:shelf][:data][:id]).to eq(shelf.id.to_s)
        expect(fern[:relationships][:shelf][:data][:type]).to eq("shelf")
      end
    end

    it 'can send the information of a single fern' do
      user = create(:user)
      shelf = create(:shelf, user_id: user.id)
      fern = create(:fern, shelf_id: shelf.id)

      get api_v1_user_fern_path(user, fern), headers: {"HTTP_FERN_KEY" => ENV["FErn_key"]}

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to have_key(:data)
      expect(parsed_response[:data]).to be_a(Hash)

      fern_response = parsed_response[:data]

      expect(fern_response).to have_key(:id)
      expect(fern_response[:id]).to be_a(String)
      expect(fern_response[:id]).to eq(fern.id.to_s)

      expect(fern_response).to have_key(:type)
      expect(fern_response[:type]).to be_a(String)
      expect(fern_response[:type]).to eq("fern")

      expect(fern_response[:attributes]).to have_key(:name)
      expect(fern_response[:attributes][:name]).to be_a(String)
      expect(fern_response[:attributes][:name]).to eq(fern.name)

      expect(fern_response[:attributes]).to have_key(:health)
      expect(fern_response[:attributes][:health]).to be_a(Integer)
      expect(fern_response[:attributes][:health]).to eq(fern.health)

      expect(fern_response[:attributes]).to have_key(:preferred_contact_method)
      expect(fern_response[:attributes][:preferred_contact_method]).to be_a(String)
      expect(fern_response[:attributes][:preferred_contact_method]).to eq(fern.preferred_contact_method)

      expect(fern_response).to have_key(:relationships)

      expect(fern_response[:relationships]).to have_key(:shelf)
      expect(fern_response[:relationships][:shelf][:data]).to be_a(Hash)
      expect(fern_response[:relationships][:shelf][:data][:id]).to eq(shelf.id.to_s)
      expect(fern_response[:relationships][:shelf][:data][:type]).to eq("shelf")
    end

    it 'can create a new fern' do
      user = create(:user)
      shelf = user.shelves.find_by(name: 'Family')
      fern_params = ({
        name: 'The Big Pepperoni',
        preferred_contact_method: "text",
        shelf: 'Family'
      })
      headers = {"CONTENT_TYPE" => "application/json",
        "HTTP_FERN_KEY" => ENV["FErn_key"]}

      post "/api/v1/users/#{user.google_id}/ferns", headers: headers, params: JSON.generate(fern_params)
      created_fern = Fern.last

      expect(response).to be_successful
      expect(created_fern.name).to eq("The Big Pepperoni")
      expect(created_fern.health).to eq(7)
      expect(created_fern.preferred_contact_method).to eq("text")
      expect(created_fern.shelf_id).to eq(shelf.id)
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
      headers = { 'CONTENT_TYPE' => 'application/json',
        "HTTP_FERN_KEY" => ENV["FErn_key"] }
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

      delete api_v1_user_fern_path(user.id, fern.id), headers: {"HTTP_FERN_KEY" => ENV["FErn_key"]}

      expect(response).to be_successful
      expect{ Fern.find(fern.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'can call the sentiment analazyer and update the health of a fern and return that new fern', :vcr do
      user = create(:user)
      shelf = create(:shelf, user_id: user.id)
      fern = create(:fern, shelf_id: shelf.id)
      message = "Hello. I am a muffin. Eat me."
      patch api_v1_user_fern_path(user.id, fern.id), params: { message: message }, headers: {"HTTP_FERN_KEY" => ENV["FErn_key"]}

      updated_fern = Fern.find_by(id: fern.id)
      expect(updated_fern.health).to eq(fern.health - 1)


    end
  end

  describe "sad path testing" do
    it 'will not update a fern without filling all fields in' do
      user = create(:user)
      shelf = create(:shelf, user_id: user.id)
      shelf2 = create(:shelf, user_id: user.id)
      fern = create(:fern, 
                    shelf_id: shelf.id,
                    name: "Fernilicious",
                    preferred_contact_method: "email")

      fern_update_params = {shelf_id: shelf2.id,
                            name: "",
                            preferred_contact_method: "Don't"}

      headers = { 'CONTENT_TYPE' => 'application/json',
        "HTTP_FERN_KEY" => ENV["FErn_key"] }

      fern_id = fern.id
      patch api_v1_user_fern_path(user.id, fern_id), headers: headers, params: JSON.generate(fern_update_params)
      updated_fern = Fern.find_by(id: fern_id)

      expect(response).to_not be_successful
    end

    it "will not create a fern if a field is left blank" do
      user = create(:user)
      shelf = create(:shelf, user_id: user.id)
      fern_params = ({
        name: '',
        preferred_contact_method: "text",
        shelf: 'Family'
      })

      headers = {"CONTENT_TYPE" => "application/json",
        "HTTP_FERN_KEY" => ENV["FErn_key"]}

      post "/api/v1/users/#{user.google_id}/ferns", headers: headers, params: JSON.generate(fern_params)

      expect(response).to_not be_successful
    end
  end
end