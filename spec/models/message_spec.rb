require 'rails_helper'

RSpec.describe Message, type: :model do
  ActiveJob::Base.queue_adapter = :test

  before(:each) do
    @user = FactoryGirl.create(:user)
    @conversation = FactoryGirl.create(:conversation)
    @conversation.users << @user
    @message = FactoryGirl.build(:message, conversation: @conversation, user: @user)
  end

  describe "check fields" do
    it { expect(@message).to respond_to(:user) }
    it { expect(@message).to respond_to(:conversation) }
    it { expect(@message).to respond_to(:content) }
  end

  describe "check present user" do
    before { @message.user = nil}
    it { expect(@message).not_to be_valid}
  end

  describe "check present conversation" do
    before { @message.conversation = nil}
    it { expect(@message).not_to be_valid}
  end

  describe "check present conversation" do
    before { @message.conversation = nil}
    it { expect(@message).not_to be_valid}
  end

  describe "check enqueue job after commit" do
    it { expect{@message.save}.to have_enqueued_job(MessageBroadcastJob) }
  end

  describe "check message length" do
    before { @message.content = "123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 "}
    it { expect(@message).not_to be_valid }
  end
end
