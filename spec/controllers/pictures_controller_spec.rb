require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  render_views
  let!(:picture) { FactoryGirl.create(:picture) }

  it "show all pictures" do
    get :index
    expect(response).to render_template("pictures/index")
    expect(response.body).to match /#{category_picture_path(picture.category, picture)}/
  end

  it "show discussed pictures" do
    xhr :get, :index, format: :js, all: false
    expect(response.content_type).to eq("text/javascript")
    expect(assigns(:pictures).count).to eq(0)
    FactoryGirl.create(:comment, picture: picture, user: picture.user)
    xhr :get, :index, format: :js, all: false
    expect(assigns(:pictures).count).to eq(1)
  end

  it "show picture" do
    get :show, { id: picture, category_id: picture.category }
    expect(response).to render_template("pictures/show")
    expect(response.body).to match /#{picture.location}/
  end

  it "upload new image" do
    #path = "/home/skripko_a/pic_dir/alcohol/alc_1.jpg"
    sign_in picture.user
    request.env["HTTP_REFERER"] = root_path
    # post :create, { picture: {description: "test", category_id: picture.category,
    #                 location: Rack::Test::UploadedFile.new(path, 'image/jpg', true) } }
    expect { post :create, picture: { description: "test", category_id: picture.category.id,
                    location: [fixture_file_upload("alc_1.jpg", 'image/jpg')] } }.to change( Picture, :count).by(1)

    expect(response).to redirect_to(root_path)


  end
end
