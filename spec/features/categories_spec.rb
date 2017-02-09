require 'rails_helper'

RSpec.feature "Categories", type: :feature do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @category = FactoryGirl.create(:category)
    @picture = FactoryGirl.create(:picture, user: @user, category: @category)
  end

  describe "view category list", type: :feature do
    before do
      sign_in @user
      visit categories_path
    end

    it "show category list" do
      expect(page).to have_content("All categories")
    end

    it "have form for new category" do
      page.has_field?('category_name')
      page.has_field?('category_description')
      page.has_button?('Create Category')      #
    end

    it "create new category" do
      fill_in ("category_name"), with: "new category"
      fill_in ("category_description"), with: "new category"
      click_button('Create Category')
      page.has_link?(category_path(Category.find_by_name("new category")))
    end

    it "follow and unfollow category" do
      expect { find(:xpath, "//a[@href='#{create_relation_category_path(@category)}']").click }.to change(UserCategory, :count).by(1)
      expect { find(:xpath, "//a[@href='#{delete_relation_category_path(@category)}']").click }.to change(UserCategory, :count).by(-1)
    end

  end
end
