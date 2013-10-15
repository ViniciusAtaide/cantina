# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131014234048) do

  create_table "categoria", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "consumidors", :force => true do |t|
    t.string   "tipo"
    t.string   "operacao"
    t.decimal  "saldo",      :precision => 10, :scale => 2
    t.string   "nome"
    t.string   "cpf"
    t.string   "email"
    t.string   "telefone"
    t.text     "observacao"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "estoques", :force => true do |t|
    t.integer  "quantidade_estoque"
    t.integer  "quantidade_min"
    t.decimal  "preco_compra",       :precision => 10, :scale => 0
    t.decimal  "custo_medio",        :precision => 10, :scale => 0
    t.integer  "produto_id"
    t.integer  "fornecedor_id"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "estoques", ["fornecedor_id"], :name => "index_estoques_on_fornecedor_id"
  add_index "estoques", ["produto_id"], :name => "index_estoques_on_produto_id"

  create_table "fornecedors", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "produtos", :force => true do |t|
    t.string   "nome"
    t.text     "descricao"
    t.string   "unidade_medida"
    t.decimal  "preco_venda",       :precision => 10, :scale => 2
    t.integer  "categoria_id"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
  end

  add_index "produtos", ["categoria_id"], :name => "index_produtos_on_categoria_id"

  create_table "vendas", :force => true do |t|
    t.integer  "quantidade_venda"
    t.decimal  "valor_total",      :precision => 10, :scale => 2
    t.integer  "consumidor_id"
    t.integer  "produto_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "vendas", ["consumidor_id"], :name => "index_vendas_on_consumidor_id"
  add_index "vendas", ["produto_id"], :name => "index_vendas_on_produto_id"

end
