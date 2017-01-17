require 'rails_helper'

RSpec.describe Event, type: :model do
  #let(:event) { FactoryGirl.build(:event) }
  before(:each) { @event = FactoryGirl.build(:event) }

  describe "check fields" do
    it { expect(@event).to respond_to(:user) }
    it { expect(@event).to respond_to(:event_type) }
    it { expect(@event).to respond_to(:details) }
  end

  describe "check user present" do
    before do
      @event.user = nil
    end

    it { expect(@event).not_to be_valid }
  end

end
