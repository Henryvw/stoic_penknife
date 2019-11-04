class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.belongs_to :tag, index: true
      t.bigint :tagable_id
      t.string :tagable_type

      t.timestamps
    end

    add_index :taggings, %i[tagable_type tagable_id]
  end
end
