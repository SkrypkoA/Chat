require 'spec_helper'
require 'rails_helper'


RSpec.feature "Conversation", type: :feature do
 # include Devise::Test::IntegrationHelpers
  before(:all) do
    @user = FactoryGirl.create(:user)
    @second_user = FactoryGirl.create(:second_user)
  end

  after(:all) do
    User.delete_all
    Conversation.delete_all
  end

  describe "home page", js: true, type: :feature do
    before do
      sign_in @user
      visit root_path
    end

    it "should create a message" do
      expect(find(:css, 'div.user-list').visible?).to be false
      find(:css,'.hide-chat-btn').click
      click_link(@second_user.email)
      find('#dropdownMenu2').click
      expect(find('.user-list').visible?).to be true
      fill_in ("message_content"), with: "some message"
      find('input.message_button').click
      expect { find('input.message_button').click}.to change(Message, :count).by(1)
      sleep(5)
    end
  end
end
