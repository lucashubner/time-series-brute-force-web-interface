require 'test_helper'

class TsResultsControllerTest < ActionController::TestCase
  setup do
    @ts_result = ts_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ts_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ts_result" do
    assert_difference('TsResult.count') do
      post :create, ts_result: { limear: @ts_result.limear, motif_size: @ts_result.motif_size, normalize: @ts_result.normalize, ts_tbl_id: @ts_result.ts_tbl_id }
    end

    assert_redirected_to ts_result_path(assigns(:ts_result))
  end

  test "should show ts_result" do
    get :show, id: @ts_result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ts_result
    assert_response :success
  end

  test "should update ts_result" do
    patch :update, id: @ts_result, ts_result: { limear: @ts_result.limear, motif_size: @ts_result.motif_size, normalize: @ts_result.normalize, ts_tbl_id: @ts_result.ts_tbl_id }
    assert_redirected_to ts_result_path(assigns(:ts_result))
  end

  test "should destroy ts_result" do
    assert_difference('TsResult.count', -1) do
      delete :destroy, id: @ts_result
    end

    assert_redirected_to ts_results_path
  end
end
