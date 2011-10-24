require 'test_helper'

class PoiCategoriesControllerTest < ActionController::TestCase
  setup do
    @poi_category = poi_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poi_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poi_category" do
    assert_difference('PoiCategory.count') do
      post :create, :poi_category => @poi_category.attributes
    end

    assert_redirected_to poi_category_path(assigns(:poi_category))
  end

  test "should show poi_category" do
    get :show, :id => @poi_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @poi_category.to_param
    assert_response :success
  end

  test "should update poi_category" do
    put :update, :id => @poi_category.to_param, :poi_category => @poi_category.attributes
    assert_redirected_to poi_category_path(assigns(:poi_category))
  end

  test "should destroy poi_category" do
    assert_difference('PoiCategory.count', -1) do
      delete :destroy, :id => @poi_category.to_param
    end

    assert_redirected_to poi_categories_path
  end
end
