require 'test_helper'

class ContaControllerTest < ActionController::TestCase
  setup do
    @conta = conta(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conta)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conta" do
    assert_difference('Conta.count') do
      post :create, conta: { correntista_id: @conta.correntista_id, created_at: @conta.created_at, flag_ativo: @conta.flag_ativo, id: @conta.id, saldo: @conta.saldo, updated_at: @conta.updated_at }
    end

    assert_redirected_to conta_path(assigns(:conta))
  end

  test "should show conta" do
    get :show, id: @conta
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conta
    assert_response :success
  end

  test "should update conta" do
    patch :update, id: @conta, conta: { correntista_id: @conta.correntista_id, created_at: @conta.created_at, flag_ativo: @conta.flag_ativo, id: @conta.id, saldo: @conta.saldo, updated_at: @conta.updated_at }
    assert_redirected_to conta_path(assigns(:conta))
  end

  test "should destroy conta" do
    assert_difference('Conta.count', -1) do
      delete :destroy, id: @conta
    end

    assert_redirected_to conta_index_path
  end
end
