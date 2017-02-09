require 'rails_helper'

RSpec.describe Conversation, type: :model do
  # before(:each) do
  #   @conversation = FactoryGirl.create(:conversation)
  # end
  let!(:conversation){ FactoryGirl.create(:conversation) }

  describe "check fields" do
    it { expect(conversation).to respond_to(:messages) }
    it { expect(conversation).to respond_to(:conversations_users) }
    it { expect(conversation).to respond_to(:users) }
  end

  describe "check dependent destroy" do
    it do
      @conv = conversation
      @user = FactoryGirl.create(:user)
      @second_user = FactoryGirl.create(:second_user)
      @conv.users << @user
      @conv.users << @second_user
      FactoryGirl.create(:message, conversation: @conv, user: @user)
      FactoryGirl.create(:message, conversation: @conv, user: @second_user)
      conv_users = conversation.conversations_users.to_a
      @conv.destroy
      expect(conv_users).not_to be_empty
      expect(ConversationsUser.where(conversation_id: conv_users.first.conversation_id)).to be_empty
    end
  end

end
