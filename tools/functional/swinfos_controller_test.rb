require 'test_helper'

class SwinfosControllerTest < ActionController::TestCase
  setup do
    @swinfo = swinfos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:swinfos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create swinfo" do
    assert_difference('Swinfo.count') do
      post :create, swinfo: { show: @swinfo.show }
    end

    assert_redirected_to swinfo_path(assigns(:swinfo))
  end

  test "should show swinfo" do
    get :show, id: @swinfo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @swinfo
    assert_response :success
  end

  test "should update swinfo" do
    put :update, id: @swinfo, swinfo: { show: @swinfo.show }
    assert_redirected_to swinfo_path(assigns(:swinfo))
  end

  test "should destroy swinfo" do
    assert_difference('Swinfo.count', -1) do
      delete :destroy, id: @swinfo
    end

    assert_redirected_to swinfos_path
  end
end
