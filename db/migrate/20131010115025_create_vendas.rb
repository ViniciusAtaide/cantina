class CreateVendas < ActiveRecord::Migration
  def change
    create_table :vendas do |t|
      t.integer :quantidade_venda
      t.decimal :valor_total, :precision => 10, :scale => 2
      t.integer :consumidor_id
      t.integer :produto_id

      t.timestamps
    end
    add_index :vendas, :consumidor_id
    add_index :vendas, :produto_id
  end
end
