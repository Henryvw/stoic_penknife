class CreateMeditationTaggings < ActiveRecord::Migration
  def change
    create_table :meditation_taggings do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :meditation, index: true

      t.timestamps
    end
  end
end
