require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  render_views

  let!(:user) { FactoryGirl.create(:user) }
  let!(:second_user) { FactoryGirl.create(:second_user) }
  let!(:conversation) { FactoryGirl.create(:conversation) }

  it "renders the conversations/show template with messages" do
    sign_in user
    get :show, { id: conversation }
    expect(response).to render_template("conversations/show")
    expect(response.body).to match /"message_content"/
  end

  it "get conversation partial" do
    sign_in user
    request.env["HTTP_REFERER"] = root_path
    get :show_partial, { id: conversation}
    expect(response).to redirect_to(root_path)
    get :show_partial, { format: :json, id: conversation}
    expect(response.content_type).to eq "application/json"
    expect(JSON.parse(response.body)["html"]).to match /message_content/
  end

  it "create conversation" do
    sign_in user
    expect { post :create, { user_id: second_user } }.to change(Conversation, :count).by(1)
    expect { post :create, { user_id: second_user } }.to change(Conversation, :count).by(0)
    expect(response).to redirect_to(conversation_path(user.conversations.last))
    post :create, { format: :json, user_id: second_user }
    expect(response.content_type).to eq "application/json"
    expect(JSON.parse(response.body)["conversation_id"]).to eq(user.conversations.last.id)
  end
end
