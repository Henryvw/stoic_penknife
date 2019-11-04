class DropDoctrineTaggings < ActiveRecord::Migration[5.2]
  def up
    drop_table :doctrine_taggings
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
