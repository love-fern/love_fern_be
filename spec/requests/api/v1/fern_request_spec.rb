require 'rails_helper'

RSpec.describe "ferns API endpoints" do
  it 'sends a list of all a users ferns' do
    user = create(:user)
    fern1 = create(:fern, user_id: user.id)
    fern2 = create(:fern, user_id: user.id)
    fern3 = create(:fern, user_id: user.id)

    get '/api/v1/greenhouse'
    # google_auth_params = {
    #   name: "Tony Pepperoni",
    #   email: "thebigpepperoni@gmail.com",
    #   google_id: "iosdfh454"
    # }
  end


end