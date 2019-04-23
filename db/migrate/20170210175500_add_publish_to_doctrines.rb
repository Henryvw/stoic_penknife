class AddPublishToDoctrines < ActiveRecord::Migration[5.2]
  def change
    add_column :doctrines, :publish, :boolean
  end
end
