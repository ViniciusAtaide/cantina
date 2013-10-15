class CreateEstoques < ActiveRecord::Migration
  def change
    create_table :estoques do |t|
      t.integer :quantidade_estoque
      t.integer :quantidade_min
      t.decimal :preco_compra
      t.decimal :custo_medio
      t.integer :produto_id
      t.integer :fornecedor_id

      t.timestamps
    end
    add_index :estoques, :produto_id
    add_index :estoques, :fornecedor_id
  end
end
