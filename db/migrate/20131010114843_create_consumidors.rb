class CreateConsumidors < ActiveRecord::Migration
  def change
    create_table :consumidors do |t|
      t.string :tipo
      t.string :operacao
      t.decimal :saldo, :precision => 10, :scale => 2, :default => 0
      t.string :nome
      t.string :cpf
      t.string :email
      t.string :telefone
      t.text :observacao

      t.timestamps
    end
  end
end
