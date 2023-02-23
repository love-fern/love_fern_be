require 'rails_helper'

RSpec.describe Shelf do
  describe "relationships" do
    it { should have_many(:ferns) }
    it { should belong_to(:user) }
  end

end