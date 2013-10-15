require 'test_helper'

class EstoquesControllerTest < ActionController::TestCase
  setup do
    @estoque = estoques(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estoques)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estoque" do
    assert_difference('Estoque.count') do
      post :create, estoque: { custo_medio: @estoque.custo_medio, fornecedor_id: @estoque.fornecedor_id, preco_compra: @estoque.preco_compra, produto_id: @estoque.produto_id, quantidade_estoque: @estoque.quantidade_estoque, quantidade_min: @estoque.quantidade_min }
    end

    assert_redirected_to estoque_path(assigns(:estoque))
  end

  test "should show estoque" do
    get :show, id: @estoque
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estoque
    assert_response :success
  end

  test "should update estoque" do
    put :update, id: @estoque, estoque: { custo_medio: @estoque.custo_medio, fornecedor_id: @estoque.fornecedor_id, preco_compra: @estoque.preco_compra, produto_id: @estoque.produto_id, quantidade_estoque: @estoque.quantidade_estoque, quantidade_min: @estoque.quantidade_min }
    assert_redirected_to estoque_path(assigns(:estoque))
  end

  test "should destroy estoque" do
    assert_difference('Estoque.count', -1) do
      delete :destroy, id: @estoque
    end

    assert_redirected_to estoques_path
  end
end
