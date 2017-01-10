#require 'test_helper'
require 'spec_helper'
require 'rails_helper'


# Capybara.register_server :puma do |app, port, host|
#   require 'puma'
#   Puma::Server.new(app).tap do |s|
#     s.add_tcp_listener host, port
#   end.run.join
# end

# Capybara.server {|app, port|
#   require 'puma'
#   Puma::Server.new(app).tap do |s|
#     s.add_tcp_listener Capybara.server_host, port
#   end.run.join
# }
class ConversationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  describe "Conversation" do
    #subject { page }

    describe "home page", js: true, type: :feature do
      before do
        #using_wait_time(10)
        sign_in User.first
        visit root_path

      end

      it "should create a message" do
        expect(find(:css, 'div.user-list').visible?).to be false
        find(:css,'.hide-chat-btn').click
        #find(:css, '.user-list').visible?
        #puts find(:css, '.user-list').visible?
        #       using_wait_time(10) do
        click_link('ixsiwat@gmail.com')
        #find('ixsiwat@gmail.com').click
        #end
        find('#dropdownMenu2').click
        expect(find('.user-list').visible?).to be true
        fill_in ("message_content"), with: "some message"
        puts "###"+ find(".message_content").text
        find('input.message_button').click
        #sleep 140.0
        puts Message.count
        expect { find('input.message_button').click}.to change(Message, :count).by(1)
      end
    end
  end

end