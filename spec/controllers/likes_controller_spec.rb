require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  render_views
  let!(:picture) { FactoryGirl.create(:picture) }
  it "like the picture" do
    sign_in picture.user
    expect { post :create, { format: :json, picture_id: picture } }.to change { picture.likes.count }.by(1)
    expect(JSON.parse(response.body)["likes_count"]).to eq(Picture.find(picture.id).likes_count)
    expect(JSON.parse(response.body)["html"]).to match /unlike/
    expect { post :create, { format: :json, picture_id: picture } }.to raise_error
  end

  it "unlike the picture" do
    sign_in picture.user
    like = FactoryGirl.create(:like, user: picture.user, picture: picture)
    expect { delete :destroy, { format: :json, id: like.id, picture_id: picture } }.to change { picture.likes.count }.by(-1)
    expect(JSON.parse(response.body)["likes_count"]).to eq(Picture.find(picture.id).likes_count)
    expect(JSON.parse(response.body)["html"]).not_to match /unlike/
    expect { delete :destroy, { format: :json, picture_id: picture } }.to raise_error
  end

end
