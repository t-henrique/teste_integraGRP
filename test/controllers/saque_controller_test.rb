require 'test_helper'

class SaqueControllerTest < ActionController::TestCase
  setup do
    @saque = saque(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saque)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saque" do
    assert_difference('Saque.count') do
      post :create, saque: { conta_id: @saque.conta_id, created_at: @saque.created_at, valor: @saque.valor }
    end

    assert_redirected_to saque_path(assigns(:saque))
  end

  test "should show saque" do
    get :show, id: @saque
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saque
    assert_response :success
  end

  test "should update saque" do
    patch :update, id: @saque, saque: { conta_id: @saque.conta_id, created_at: @saque.created_at, valor: @saque.valor }
    assert_redirected_to saque_path(assigns(:saque))
  end

  test "should destroy saque" do
    assert_difference('Saque.count', -1) do
      delete :destroy, id: @saque
    end

    assert_redirected_to saque_index_path
  end
end
