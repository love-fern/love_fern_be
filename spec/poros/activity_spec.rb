require 'rails_helper'

RSpec.describe Activity, type: :poro do
  context 'initialize' do
    it 'has attributes' do
      data = {
        :activity=>"Random Activity",
            }
      activity = Activity.new(data)

      expect(activity).to be_an(Activity)
      expect(activity.activity).to eq('Random Activity')
    end
  end
end