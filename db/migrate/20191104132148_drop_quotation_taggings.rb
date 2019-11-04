class DropQuotationTaggings < ActiveRecord::Migration[5.2]
  def up
    drop_table :quotation_taggings
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
