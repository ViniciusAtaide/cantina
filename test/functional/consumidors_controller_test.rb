require 'test_helper'

class ConsumidorsControllerTest < ActionController::TestCase
  setup do
    @consumidor = consumidors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:consumidors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create consumidor" do
    assert_difference('Consumidor.count') do
      post :create, consumidor: { cpf: @consumidor.cpf, email: @consumidor.email, nome: @consumidor.nome, observacao: @consumidor.observacao, operacao: @consumidor.operacao, telefone: @consumidor.telefone, tipo: @consumidor.tipo, valor_recebido: @consumidor.valor_recebido }
    end

    assert_redirected_to consumidor_path(assigns(:consumidor))
  end

  test "should show consumidor" do
    get :show, id: @consumidor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @consumidor
    assert_response :success
  end

  test "should update consumidor" do
    put :update, id: @consumidor, consumidor: { cpf: @consumidor.cpf, email: @consumidor.email, nome: @consumidor.nome, observacao: @consumidor.observacao, operacao: @consumidor.operacao, telefone: @consumidor.telefone, tipo: @consumidor.tipo, valor_recebido: @consumidor.valor_recebido }
    assert_redirected_to consumidor_path(assigns(:consumidor))
  end

  test "should destroy consumidor" do
    assert_difference('Consumidor.count', -1) do
      delete :destroy, id: @consumidor
    end

    assert_redirected_to consumidors_path
  end
end
