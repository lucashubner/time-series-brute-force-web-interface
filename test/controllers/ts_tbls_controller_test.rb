require 'test_helper'

class TsTblsControllerTest < ActionController::TestCase
  setup do
    @ts_tbl = ts_tbls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ts_tbls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ts_tbl" do
    assert_difference('TsTbl.count') do
      post :create, ts_tbl: { ts_file_path: @ts_tbl.ts_file_path, user_id: @ts_tbl.user_id }
    end

    assert_redirected_to ts_tbl_path(assigns(:ts_tbl))
  end

  test "should show ts_tbl" do
    get :show, id: @ts_tbl
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ts_tbl
    assert_response :success
  end

  test "should update ts_tbl" do
    patch :update, id: @ts_tbl, ts_tbl: { ts_file_path: @ts_tbl.ts_file_path, user_id: @ts_tbl.user_id }
    assert_redirected_to ts_tbl_path(assigns(:ts_tbl))
  end

  test "should destroy ts_tbl" do
    assert_difference('TsTbl.count', -1) do
      delete :destroy, id: @ts_tbl
    end

    assert_redirected_to ts_tbls_path
  end
end
