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



end