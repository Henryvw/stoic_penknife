class CreateDoctrineTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :doctrine_taggings do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :doctrine, index: true
      t.timestamps
    end
  end
end
