require 'rails_helper'

RSpec.describe "ferns API endpoints" do
  it 'sends a list of all a users ferns' do
    user1 = create(:user)
    fern1 = create(:fern, user_id: user1.id)
    fern2 = create(:fern, user_id: user1.id)
    fern3 = create(:fern, user_id: user1.id)

    get api_v1_user_greenhouse_path(user1.id)
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

      expect(fern[:attributes]).to have_key(:duration)
      expect(fern[:attributes][:duration]).to be_a(Integer)

      expect(fern[:attributes]).to have_key(:tag)
      expect(fern[:attributes][:tag]).to be_a(String)

      expect(fern[:attributes]).to have_key(:health)
      expect(fern[:attributes][:health]).to be_a(Integer)

      expect(fern[:attributes]).to have_key(:user_id)
      expect(fern[:attributes][:user_id]).to be_a(Integer)
    end
  end
end