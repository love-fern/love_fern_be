require 'rails_helper'

RSpec.describe "user API requests" do
  it 'can create a new user in the database' do
    google_auth_params = {
        name: "I am an authorized user",
        email: "nice_person@gmail.com",
        google_id: "23948sdkss"
      }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(user: google_auth_params)
    created_user = User.last

    expect(response).to be_successful
    expect(created_user.name).to eq("I am an authorized user")
    expect(created_user.email).to eq("nice_person@gmail.com")
    expect(created_user.google_id).to eq("23948sdkss")
  end

  it 'can modify a users name' do
    user = create(:user)
    id = user.id
    expect(user.name).to_not eq("this is my new name")

    name_change_params = { name: "this is my new name" }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    patch "/api/v1/user/#{id}", headers: headers, params: JSON.generate(user: name_change_params)

    updated_user = User.find_by(id: id)
    expect(response).to be_successful
    expect(updated_user.name).to eq("this is my new name")
    expect(updated_user.email).to eq(user.email)
    expect(updated_user.google_id).to eq(user.google_id)
  end



end