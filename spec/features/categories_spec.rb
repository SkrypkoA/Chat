require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  # let!(:user) { FactoryGirl.create(:user) }
  # let!(:category) { FactoryGirl.create(:category) }
  # let!(:picture) { FactoryGirl.create(:picture, user: user, category: category) }

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
      page.has_button?('Create Category')
      #
    end

    it "create new category" do
      fill_in ("category_name"), with: "new category"
      fill_in ("category_description"), with: "new category"
      #expect { }.to change(Category, :count).by(1)
      click_button('Create Category')
      page.has_link?(category_path(Category.find_by_name("new category")))
    end

    # it "follow and unfollow category" do
    #   expec { click_link(create_relation_category_path(@category)) }.to
    # end

  end

end
