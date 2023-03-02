require 'rails_helper'

RSpec.describe 'ferns API endpoints' do
  let!(:headers) { { 'HTTP_FERN_KEY' => ENV['FERN_KEY'] } }
  let!(:user) { create(:user) }
  let!(:shelf) { create(:shelf, user_id: user.id) }
  let(:fern) { create(:fern, shelf_id: shelf.id) }

  describe 'happy path testing' do
    describe 'fern index' do
      let!(:ferns) { create_list(:fern, 3, shelf_id: shelf.id) }
      before { get api_v1_user_ferns_path(user.google_id), headers: headers }

      it 'sends all ferns for a user' do
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
          expect(fern[:type]).to eq('fern')

          expect(fern[:attributes]).to have_key(:name)
          expect(fern[:attributes][:name]).to be_a(String)
          expect(fern[:attributes][:name]).to eq(ferns[i].name)

          expect(fern[:attributes]).to have_key(:health)
          expect(fern[:attributes][:health]).to be_a(Integer)
          expect(fern[:attributes][:health]).to eq(ferns[i].health)

          expect(fern[:attributes]).to have_key(:preferred_contact_method)
          expect(fern[:attributes][:preferred_contact_method]).to be_a(String)
          expect(fern[:attributes][:preferred_contact_method]).to eq(ferns[i].preferred_contact_method)
        end
      end

      it 'sends fern relationships' do
        ferns_response = JSON.parse(response.body, symbolize_names: true)[:data]

        ferns_response.each do |fern|
          expect(fern).to have_key(:relationships)

          expect(fern[:relationships]).to have_key(:shelf)
          expect(fern[:relationships][:shelf][:data]).to be_a(Hash)
          expect(fern[:relationships][:shelf][:data][:id]).to eq(shelf.id.to_s)
          expect(fern[:relationships][:shelf][:data][:type]).to eq('shelf')

          expect(fern[:relationships]).to have_key(:user)
          expect(fern[:relationships][:user][:data]).to be_a(Hash)
          expect(fern[:relationships][:user][:data][:id]).to eq(user.id.to_s)
          expect(fern[:relationships][:user][:data][:type]).to eq('user')

          expect(fern[:relationships]).to have_key(:interactions)
          expect(fern[:relationships][:interactions][:data]).to be_an(Array)
        end
      end
    end

    describe 'fern show' do
      let!(:interaction1) { create(:interaction, fern_id: fern.id, created_at: Time.now - 1.days) }
      let!(:interaction2) { create(:interaction, fern_id: fern.id, created_at: Time.now - 2.days) }
      let!(:interaction3) { create(:interaction, fern_id: fern.id) }
      let!(:interaction4) { create(:interaction, fern_id: fern.id, created_at: Time.now - 3.days) }
      before { get api_v1_user_fern_path(user.google_id, fern.id), headers: headers }

      it 'sends one fern for a user' do
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
        expect(fern_response[:type]).to eq('fern')

        expect(fern_response[:attributes]).to have_key(:name)
        expect(fern_response[:attributes][:name]).to be_a(String)
        expect(fern_response[:attributes][:name]).to eq(fern.name)

        expect(fern_response[:attributes]).to have_key(:health)
        expect(fern_response[:attributes][:health]).to be_a(Integer)
        expect(fern_response[:attributes][:health]).to eq(fern.health)

        expect(fern_response[:attributes]).to have_key(:preferred_contact_method)
        expect(fern_response[:attributes][:preferred_contact_method]).to be_a(String)
        expect(fern_response[:attributes][:preferred_contact_method]).to eq(fern.preferred_contact_method)
      end

      it 'sends fern relationships' do
        fern_response = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(fern_response).to have_key(:relationships)

        expect(fern_response[:relationships]).to have_key(:shelf)
        expect(fern_response[:relationships][:shelf][:data]).to be_a(Hash)
        expect(fern_response[:relationships][:shelf][:data][:id]).to eq(shelf.id.to_s)
        expect(fern_response[:relationships][:shelf][:data][:type]).to eq('shelf')

        expect(fern_response[:relationships]).to have_key(:user)
        expect(fern_response[:relationships][:user][:data]).to be_a(Hash)
        expect(fern_response[:relationships][:user][:data][:id]).to eq(user.id.to_s)
        expect(fern_response[:relationships][:user][:data][:type]).to eq('user')

        expect(fern_response[:relationships]).to have_key(:interactions)
        expect(fern_response[:relationships][:interactions][:data]).to be_an(Array)

        expected_interactions = [interaction3, interaction1, interaction2]

        fern_response[:relationships][:interactions][:data].each_with_index do |_interaction, i|
          expect(fern_response[:relationships][:interactions][:data][i][:id]).to eq(expected_interactions[i].id.to_s)
          expect(fern_response[:relationships][:interactions][:data][i][:type]).to eq('interaction')
        end
      end

      it 'includes user attributes' do
        included_response = JSON.parse(response.body, symbolize_names: true)[:included]
        included_response.select! { |included| included[:type] == 'user' }

        expect(included_response.count).to eq(1)

        expect(included_response[0]).to have_key(:id)
        expect(included_response[0][:id]).to eq(user.id.to_s)

        expect(included_response[0]).to have_key(:type)
        expect(included_response[0][:type]).to eq('user')

        expect(included_response[0]).to have_key(:attributes)
        expect(included_response[0][:attributes]).to be_a(Hash)

        expect(included_response[0][:attributes]).to have_key(:name)
        expect(included_response[0][:attributes][:name]).to eq(user.name)

        expect(included_response[0][:attributes]).to have_key(:email)
        expect(included_response[0][:attributes][:email]).to eq(user.email)

        expect(included_response[0][:attributes]).to have_key(:google_id)
        expect(included_response[0][:attributes][:google_id]).to eq(user.google_id)
      end

      it 'includes attributes for the last 3 interactions' do
        included_response = JSON.parse(response.body, symbolize_names: true)[:included]
        included_response.select! { |included| included[:type] == 'interaction' }

        expect(included_response.count).to eq(3)

        expected_interactions = [interaction3, interaction1, interaction2]

        included_response.each_with_index do |included, i|
          expect(included).to have_key(:id)
          expect(included[:id]).to eq(expected_interactions[i].id.to_s)

          expect(included).to have_key(:type)
          expect(included[:type]).to eq('interaction')

          expect(included).to have_key(:attributes)
          expect(included[:attributes]).to be_a(Hash)

          expect(included[:attributes]).to have_key(:evaluation)
          expect(included[:attributes][:evaluation]).to eq(expected_interactions[i].evaluation)

          expect(included[:attributes]).to have_key(:created_at)
          expect(included[:attributes][:created_at]).to eq(expected_interactions[i].created_at.as_json)
        end
      end
    end

    describe 'fern create' do
      let(:fern_params) do
        {
          name: 'The Big Pepperoni',
          preferred_contact_method: 'text',
          shelf: shelf.name
        }
      end
      before do
        post api_v1_user_ferns_path(user.google_id), headers: headers, params: fern_params
      end

      it 'can create a new fern' do
        expect(response).to be_successful

        created_fern = Fern.last

        expect(created_fern.name).to eq('The Big Pepperoni')
        expect(created_fern.health).to eq(7)
        expect(created_fern.preferred_contact_method).to eq('text')
        expect(created_fern.shelf_id).to eq(shelf.id)
      end

      it 'returns created fern as json' do
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to have_key(:data)
        expect(parsed_response[:data]).to be_a(Hash)

        fern_response = parsed_response[:data]

        expect(fern_response).to have_key(:id)
        expect(fern_response[:id]).to be_a(String)

        expect(fern_response).to have_key(:type)
        expect(fern_response[:type]).to be_a(String)
        expect(fern_response[:type]).to eq('fern')

        expect(fern_response).to have_key(:attributes)

        expect(fern_response[:attributes]).to have_key(:name)
        expect(fern_response[:attributes][:name]).to be_a(String)
        expect(fern_response[:attributes][:name]).to eq(fern_params[:name])

        expect(fern_response[:attributes]).to have_key(:health)
        expect(fern_response[:attributes][:health]).to be_a(Integer)
        expect(fern_response[:attributes][:health]).to eq(7)

        expect(fern_response[:attributes]).to have_key(:preferred_contact_method)
        expect(fern_response[:attributes][:preferred_contact_method]).to be_a(String)
        expect(fern_response[:attributes][:preferred_contact_method]).to eq(fern_params[:preferred_contact_method])

        expect(fern_response).to have_key(:relationships)

        expect(fern_response[:relationships]).to have_key(:shelf)
        expect(fern_response[:relationships][:shelf][:data]).to be_a(Hash)
        expect(fern_response[:relationships][:shelf][:data][:id]).to be_a(String)
        expect(fern_response[:relationships][:shelf][:data][:type]).to eq('shelf')

        expect(fern_response[:relationships]).to have_key(:user)
        expect(fern_response[:relationships][:user][:data]).to be_a(Hash)
        expect(fern_response[:relationships][:user][:data][:id]).to be_a(String)
        expect(fern_response[:relationships][:user][:data][:type]).to eq('user')
      end
    end

    describe 'fern update' do
      it 'can update an existing fern' do
        shelf2 = create(:shelf, user_id: user.id)

        fern_update_params = { shelf: shelf2.name,
                               name: 'Fernilicious',
                               preferred_contact_method: "Don't" }

        patch api_v1_user_fern_path(user.google_id, fern.id), headers: headers, params: fern_update_params
        
        updated_fern = Fern.find(fern.id)

        expect(response).to be_successful
        expect(updated_fern.shelf_id).to eq(shelf2.id)
        expect(updated_fern.name).to eq('Fernilicious')
        expect(updated_fern.preferred_contact_method).to eq("Don't")
      end

      context 'interaction sent to sentiment api' do
        it 'can decrease the health and store a negative interaction', :vcr do
          interaction = 'Die in a dumpster fire you muffin boy.' # sentiment score: -0.8
          patch api_v1_user_fern_path(user.google_id, fern.id), params: { interaction: interaction }, headers: headers
          updated_fern = Fern.find(fern.id)
          # changed this spec to look for health decrease by 2
          expect(updated_fern.health).to eq(fern.health - 2)

          interaction = updated_fern.interactions.last

          expect(interaction.evaluation).to eq('Negative')
        end

        it 'can increase the health and store a positive interaction', :vcr do
          interaction = "I'm so pleased to make your acquaintance, muffin man." # sentiment score: 0.9
          patch api_v1_user_fern_path(user.google_id, fern.id), params: { interaction: interaction }, headers: headers
          updated_fern = Fern.find(fern.id)

          # changed this spec to look for health increase by 2
          expect(updated_fern.health).to eq(fern.health + 2)

          interaction = updated_fern.interactions.last

          expect(interaction.evaluation).to eq('Positive')
        end

        it 'can leave health unchanged and store a neutral interaction', :vcr do
          interaction = 'Hello. I am a muffin. Eat me. Please and thank you.' # sentiment score: 0
          patch api_v1_user_fern_path(user.google_id, fern.id), params: { interaction: interaction }, headers: headers
          updated_fern = Fern.find(fern.id)

          expect(updated_fern.health).to eq(fern.health)

          interaction = updated_fern.interactions.last

          expect(interaction.evaluation).to eq('Neutral')
        end
      end

      context 'activity done with person' do
        it 'sets fern health to 8 and stores activity' do
          fern.health = 1
          activity = 'Learn Javascript'
          patch api_v1_user_fern_path(user.google_id, fern.id), params: { activity: activity }, headers: headers
          updated_fern = Fern.find(fern.id)

          expect(updated_fern.health).to eq(8)

          interaction = updated_fern.interactions.last

          expect(interaction.evaluation).to eq('Positive')
          expect(interaction.description).to eq('Learn Javascript')
        end
      end
    end

    describe 'fern delete' do
      it 'can delete a fern from the database' do
        expect(Fern.find(fern.id)).to eq(fern)

        delete api_v1_user_fern_path(user.google_id, fern.id), headers: headers

        expect(response).to be_successful
        expect { Fern.find(fern.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'sad path testing' do
    describe 'fern show' do
      it 'will return an error if the fern does not exist' do
        get api_v1_user_fern_path(user.google_id, 9999999999999999), headers: headers

        expect(response).to_not be_successful

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:message]).to eq('There was an error processing your request')
        expect(parsed_response[:errors]).to eq(["Couldn't find Fern with 'id'=9999999999999999"])
        expect(parsed_response[:status]).to eq("404")
      end
    end
    describe 'fern create' do
      it 'will not create fern if field is blank' do
        fern_params = {
          name: '',
          preferred_contact_method: 'text',
          shelf: 'Family'
        }
        previous_fern_count = Fern.count
        post api_v1_user_ferns_path(user.google_id), headers: headers, params: fern_params
        # `{:errors=>["Name can't be blank"], :message=>"There was an error processing your request", :status=>"422"}.has_key?(:error)`
        expect(Fern.count).to eq(previous_fern_count)
        expect(response).to_not be_successful

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to have_key(:errors)
        expect(parsed_response[:errors]).to be_a(Array)

        expect(parsed_response).to have_key(:message)
        expect(parsed_response[:message]).to be_a(String)

        expect(parsed_response).to have_key(:status)
        expect(parsed_response[:status]).to be_a(String)
      end
    end

    describe 'fern update' do
      it 'will not update fern if field is blank' do
        initial_fern = Fern.find(fern.id)

        shelf2 = create(:shelf, user_id: user.id)
        fern_update_params = { shelf_id: shelf2.id,
                               name: '',
                               preferred_contact_method: "Don't" }
        patch api_v1_user_fern_path(user.google_id, fern.id), headers: headers, params: fern_update_params

        updated_fern = Fern.find(fern.id)

        expect(updated_fern).to eq(initial_fern)
        expect(response).to_not be_successful

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to have_key(:errors)
        expect(parsed_response[:errors]).to be_a(Array)

        expect(parsed_response).to have_key(:message)
        expect(parsed_response[:message]).to be_a(String)

        expect(parsed_response).to have_key(:status)
        expect(parsed_response[:status]).to be_a(String)
      end
    end

    describe 'bad api key' do
      it 'returns 403 unauthorized' do
        headers = { 'HTTP_FERN_KEY' => 'not_the_key' }
        get api_v1_user_fern_path(user.google_id, fern.id), headers: headers

        expect(response).to_not be_successful
        expect(response.status).to eq(403)
      end
    end
  end
end
