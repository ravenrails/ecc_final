require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get my_account" do
    get :my_account
    assert_response :success
  end

  test "should get change_password" do
    get :change_password
    assert_response :success
  end

end
