require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:picture) {FactoryGirl.create(:picture) }
  it "show all comments" do
    get :index
    expect(response.content_type).to eq "text/html"
    expect(response).to render_template("index")
  end

  it "post comment" do
    request.env["HTTP_REFERER"] = root_path
    expect { post :create, picture_id: picture, comment: { content: "lalala" } }.to change(Comment, :count).by(0)
    sign_in user
    expect { post :create, picture_id: picture, comment: { content: "lalala" } }.to change(Comment, :count).by(1)
  end
end
