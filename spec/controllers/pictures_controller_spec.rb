require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  render_views
  let!(:picture) { FactoryGirl.create(:picture) }

  it "show all pictures" do
    get :index
    expect(response).to render_template("pictures/index")
    expect(response.body).to match /#{category_picture_path(picture.category, picture)}/
  end

  # it "show discussed pictures" do
  #   #FactoryGirl.create(:comment, user: picture.user, picture: picture)
  #   get :index, {format: :js, all: "false", xhr: true}
  #   #expect(response.body).not_to match /#{category_picture_path(picture.category, picture)}/
  #   expect(response.content_type).to eq("text/javascript")
  #   expect(assigns(:pictures).count).to eq(0)
  # end
end
