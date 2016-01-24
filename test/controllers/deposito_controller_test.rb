require 'test_helper'

class DepositoControllerTest < ActionController::TestCase
  setup do
    @deposito = deposito(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deposito)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deposito" do
    assert_difference('Deposito.count') do
      post :create, deposito: { conta_destino_id: @deposito.conta_destino_id, conta_origem_id: @deposito.conta_origem_id, id: @deposito.id, valor: @deposito.valor }
    end

    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should show deposito" do
    get :show, id: @deposito
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deposito
    assert_response :success
  end

  test "should update deposito" do
    patch :update, id: @deposito, deposito: { conta_destino_id: @deposito.conta_destino_id, conta_origem_id: @deposito.conta_origem_id, id: @deposito.id, valor: @deposito.valor }
    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should destroy deposito" do
    assert_difference('Deposito.count', -1) do
      delete :destroy, id: @deposito
    end

    assert_redirected_to deposito_index_path
  end
end
