require 'test_helper'

class CorrentistaControllerTest < ActionController::TestCase
  setup do
    @correntista = correntista(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:correntista)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create correntista" do
    assert_difference('Correntista.count') do
      post :create, correntista: { bairro: @correntista.bairro, cidade: @correntista.cidade, id: @correntista.id, cpf: @correntista.cpf, datanascimento: @correntista.datanascimento, endereco: @correntista.endereco, estado: @correntista.estado, nome: @correntista.nome, numero: @correntista.numero }
    end

    assert_redirected_to correntista_path(assigns(:correntista))
  end

  test "should show correntista" do
    get :show, id: @correntista
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @correntista
    assert_response :success
  end

  test "should update correntista" do
    patch :update, id: @correntista, correntista: { bairro: @correntista.bairro, cidade: @correntista.cidade, id: @correntista.id, cpf: @correntista.cpf, datanascimento: @correntista.datanascimento, endereco: @correntista.endereco, estado: @correntista.estado, nome: @correntista.nome, numero: @correntista.numero }
    assert_redirected_to correntista_path(assigns(:correntista))
  end

  test "should destroy correntista" do
    assert_difference('Correntista.count', -1) do
      delete :destroy, id: @correntista
    end

    assert_redirected_to correntista_index_path
  end
end
