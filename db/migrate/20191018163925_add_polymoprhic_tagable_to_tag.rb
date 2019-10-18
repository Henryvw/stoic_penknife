class AddPolymoprhicTagableToTag < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :tagable_id, :string
    add_column :tags, :tagable_type, :string

    add_index :tags, [:tagable_type, :tagable_id]
  end
end
