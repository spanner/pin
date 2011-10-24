require 'test_helper'

class PoiSetsControllerTest < ActionController::TestCase
  setup do
    @poi_set = poi_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poi_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poi_set" do
    assert_difference('PoiSet.count') do
      post :create, :poi_set => @poi_set.attributes
    end

    assert_redirected_to poi_set_path(assigns(:poi_set))
  end

  test "should show poi_set" do
    get :show, :id => @poi_set.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @poi_set.to_param
    assert_response :success
  end

  test "should update poi_set" do
    put :update, :id => @poi_set.to_param, :poi_set => @poi_set.attributes
    assert_redirected_to poi_set_path(assigns(:poi_set))
  end

  test "should destroy poi_set" do
    assert_difference('PoiSet.count', -1) do
      delete :destroy, :id => @poi_set.to_param
    end

    assert_redirected_to poi_sets_path
  end
end
