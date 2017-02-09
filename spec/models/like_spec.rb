require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) { @like = FactoryGirl.build(:like) }

  describe "check fields" do
    it { expect(@like).to respond_to(:user) }
    it { expect(@like).to respond_to(:picture) }
  end

  describe "check present user" do
    before { @like.user = nil}
    it { expect(@like).not_to be_valid}
  end

  describe "check present picture" do
    before { @like.picture = nil}
    it { expect(@like).not_to be_valid}
  end

  describe "check uniquness" do
    before do
      @like.save!
      @second_like = @like.dup
    end
    it { expect(@second_like).not_to be_valid }
  end
end
