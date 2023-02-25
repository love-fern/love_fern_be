require 'rails_helper'

RSpec.describe "user API requests" do
  it 'can create a new user in the database' do
    google_auth_params = {
        name: "I am an authorized user",
        email: "nice_person@gmail.com",
        google_id: "23948sdkss"
      }
    headers = { 'CONTENT_TYPE' => 'application/json', "FErn_key" => ENV["FErn_key"]} 
    post api_v1_users_path, headers: headers, params: JSON.generate(user: google_auth_params)
    created_user = User.last

    expect(response).to be_successful
    expect(created_user.name).to eq("I am an authorized user")
    expect(created_user.email).to eq("nice_person@gmail.com")
    expect(created_user.google_id).to eq("23948sdkss")
  end

  it 'creates 4 default shelves upon creation' do
    google_auth_params = {
        name: "I need shelves!",
        email: "shelf_person@gmail.com",
        google_id: "23948sdkss"
      }
    headers = { 'CONTENT_TYPE' => 'application/json', "FErn_key" => ENV["FErn_key"] }
    post api_v1_users_path, headers: headers, params: JSON.generate(user: google_auth_params)
    created_user = User.last
    expect(created_user.name).to eq("I need shelves!")
    expect(created_user.shelves[0].name).to eq("Friends")
    expect(created_user.shelves[1].name).to eq("Family")
    expect(created_user.shelves[2].name).to eq("Romantic")
    expect(created_user.shelves[3].name).to eq("Business")
  end

  it 'can modify a users name' do
    user = create(:user)
    id = user.id
    expect(user.name).to_not eq("this is my new name")

    name_change_params = { name: "this is my new name" }
    headers = { 'CONTENT_TYPE' => 'application/json', "FErn_key" => ENV["FErn_key"] }
    patch api_v1_user_path(id), headers: headers, params: JSON.generate(user: name_change_params)

    updated_user = User.find_by(id: id)
    expect(response).to be_successful
    expect(updated_user.name).to eq("this is my new name")
    expect(updated_user.email).to eq(user.email)
    expect(updated_user.google_id).to eq(user.google_id)
  end

  it 'can find or create a new user based on google id' do
    user = create(:user, google_id: "4")

    headers = { 'CONTENT_TYPE' => 'application/json', "FErn_key" => ENV["FErn_key"] }
    duplicate_google_id_params = {name: "Jim", google_id: "4", email: "iamjim@gmail.com"}
    post api_v1_users_path, headers: headers, params: JSON.generate(duplicate_google_id_params)

    expect(response).to be_successful
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response[:data][:attributes]).to eq({email: user.email, google_id: user.google_id, name: user.name})

  end



end