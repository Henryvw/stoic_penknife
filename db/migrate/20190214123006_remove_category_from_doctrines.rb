class RemoveCategoryFromDoctrines < ActiveRecord::Migration[5.2]
  def change
    remove_column :doctrines, :category, :string
  end
end
