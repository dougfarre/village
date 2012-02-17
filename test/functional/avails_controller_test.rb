require 'test_helper'

class AvailsControllerTest < ActionController::TestCase
  setup do
    @avail = avails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:avails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create avail" do
    assert_difference('Avail.count') do
      post :create, avail: @avail.attributes
    end

    assert_redirected_to avail_path(assigns(:avail))
  end

  test "should show avail" do
    get :show, id: @avail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @avail
    assert_response :success
  end

  test "should update avail" do
    put :update, id: @avail, avail: @avail.attributes
    assert_redirected_to avail_path(assigns(:avail))
  end

  test "should destroy avail" do
    assert_difference('Avail.count', -1) do
      delete :destroy, id: @avail
    end

    assert_redirected_to avails_path
  end
end
