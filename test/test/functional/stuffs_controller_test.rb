require 'test_helper'

class StuffsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stuffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stuff" do
    assert_difference('Stuff.count') do
      post :create, :stuff => { }
    end

    assert_redirected_to stuff_path(assigns(:stuff))
  end

  test "should show stuff" do
    get :show, :id => stuffs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => stuffs(:one).to_param
    assert_response :success
  end

  test "should update stuff" do
    put :update, :id => stuffs(:one).to_param, :stuff => { }
    assert_redirected_to stuff_path(assigns(:stuff))
  end

  test "should destroy stuff" do
    assert_difference('Stuff.count', -1) do
      delete :destroy, :id => stuffs(:one).to_param
    end

    assert_redirected_to stuffs_path
  end
end
