class CreatePedidos < ActiveRecord::Migration
  def change
    create_table :pedidos do |t|
	  	t.integer :pedido_id, :null => false
	  	t.integer :produto_id, :null => false
	  	t.integer :quantidade
	  end
	  add_index :itens, pedido_id
    end
  end
end
