class AddAttachmentFotoToProdutos < ActiveRecord::Migration
  def self.up
    change_table :produtos do |t|
      t.attachment :foto
    end
  end

  def self.down
    drop_attached_file :produtos, :foto
  end
end
