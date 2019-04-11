class RemoveCategoryFromQuotations < ActiveRecord::Migration[5.0]
  def change
    remove_column :quotations, :category, :string
  end
end
