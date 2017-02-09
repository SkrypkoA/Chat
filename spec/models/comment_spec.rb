require 'rails_helper'

RSpec.describe Comment, type: :model do

  ##let(:user) { FactoryGirl.create(:user) }
  #let(:picture) { FactoryGirl.create(:picture, user: user) }
  before(:each) do
    @comment = FactoryGirl.build(:comment)
  end


  describe "check fields" do
    it { expect(@comment).to respond_to(:picture) }
    it { expect(@comment).to respond_to(:user) }
    it { expect(@comment).to respond_to(:content) }
  end

  describe "check content length" do
    before { @comment.content = "123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 "}
    it { expect(@comment).not_to be_valid }
  end

  describe "check presence content" do
    before { @comment.content = " " }
    it { expect(@comment).not_to be_valid }
  end

  describe "check presence user" do
    before { @comment.user = nil }
    it { expect(@comment).not_to be_valid }
  end

  describe "check presence picture" do
    before { @comment.picture = nil }
    it { expect(@comment).not_to be_valid }
  end
end
