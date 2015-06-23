require 'test_helper'

class HrDataPointsControllerTest < ActionController::TestCase
  setup do
    @hr_data_point = hr_data_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hr_data_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hr_data_point" do
    assert_difference('HrDataPoint.count') do
      post :create, hr_data_point: { data_points: @hr_data_point.data_points, history_record_id: @hr_data_point.history_record_id, txn_id: @hr_data_point.txn_id }
    end

    assert_redirected_to hr_data_point_path(assigns(:hr_data_point))
  end

  test "should show hr_data_point" do
    get :show, id: @hr_data_point
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hr_data_point
    assert_response :success
  end

  test "should update hr_data_point" do
    patch :update, id: @hr_data_point, hr_data_point: { data_points: @hr_data_point.data_points, history_record_id: @hr_data_point.history_record_id, txn_id: @hr_data_point.txn_id }
    assert_redirected_to hr_data_point_path(assigns(:hr_data_point))
  end

  test "should destroy hr_data_point" do
    assert_difference('HrDataPoint.count', -1) do
      delete :destroy, id: @hr_data_point
    end

    assert_redirected_to hr_data_points_path
  end
end
