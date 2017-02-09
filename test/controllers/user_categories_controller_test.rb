require 'test_helper'

class UserCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_categories_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_categories_destroy_url
    assert_response :success
  end

end
