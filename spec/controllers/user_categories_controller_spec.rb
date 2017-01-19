require 'rails_helper'

RSpec.describe UserCategoriesController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:category) { FactoryGirl.create(:category) }

  it "follow category" do
    sign_in  user
    request.env["HTTP_REFERER"] = root_path
    expect { post :create, category_id: category }.to change(UserCategory, :count).by(1)
    expect { post :create, category_id: category }.to raise_error
  end

  it "unfollow category" do
    sign_in  user
    request.env["HTTP_REFERER"] = root_path
    expect { delete :destroy, category_id: category }.to raise_error
    FactoryGirl.create(:user_category, user: user, category: category)
    expect { delete :destroy, category_id: category }.to change(UserCategory, :count).by(-1)
    #expect { post :create, category_id: category }.to change(UserCategories, :count).by(1)
  end
end
