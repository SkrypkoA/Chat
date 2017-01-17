require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:category) { FactoryGirl.create(:category) }
  let!(:user) { FactoryGirl.create(:user) }

  it "has a 200 status code" do
    get :index
    expect(response.status).to eq(200)
  end

  it "return html" do
    get :show, { id: category }
    expect(response.content_type).to eq "text/html"
  end

  it "renders the categories/show template" do
    get :show, { id: category }
    expect(response).to render_template("categories/show")
  end

  it "user follow category" do
    sign_in user
    request.env["HTTP_REFERER"] = root_path
    expect { post :create_relation, { id: category } }.to change(UserCategory, :count).by(1)
    sign_out user
    expect { post :create_relation, { id: category } }.to raise_error
  end

  it "user unfollow category" do
    FactoryGirl.create(:user_category, user: user, category: category)
    sign_in user
    request.env["HTTP_REFERER"] = root_path
    expect { delete :delete_relation, { id: category } }.to change(UserCategory, :count).by(-1)
    sign_out user
    expect { delete :create_relation, { id: category } }.to raise_error
  end

  it "create category" do
    request.env["HTTP_REFERER"] = root_path
    expect { post :create, { category: { name: "Category", description: "test category" } } }.to change(Category, :count).by(0)
    sign_in user

    expect { post :create, { category: { name: "Category", description: "test category" } } }.to change(Category, :count).by(1)
  end
end

