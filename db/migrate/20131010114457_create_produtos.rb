class CreateProdutos < ActiveRecord::Migration
  def change
    create_table :produtos do |t|
      t.string :nome
      t.text :descricao
      t.string :unidade_medida
      t.decimal :preco_venda, :precision => 10, :scale => 2
      t.integer :categoria_id


      t.timestamps
    end
    add_index :produtos, :categoria_id
  end
end
