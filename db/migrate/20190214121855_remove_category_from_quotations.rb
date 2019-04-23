class RemoveCategoryFromQuotations < ActiveRecord::Migration[5.2]
  def change
    remove_column :quotations, :category, :string
  end
end
