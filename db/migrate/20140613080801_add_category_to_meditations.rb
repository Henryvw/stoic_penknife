class AddCategoryToMeditations < ActiveRecord::Migration[5.2]
  def change
    add_column :meditations, :category, :string
  end
end
