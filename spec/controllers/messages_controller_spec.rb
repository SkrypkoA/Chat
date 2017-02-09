require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  render_views
  let!(:message) { FactoryGirl.create(:message)}

  it "show messages" do
    get :index
    expect(response).to render_template("messages/index")
    expect(response.body).to match /#{message.content}/
  end
end
