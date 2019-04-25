class RenameMeditationTaggingsToQuotationTaggings < ActiveRecord::Migration[5.2]
  def change
    rename_table :meditation_taggings, :quotation_taggings
  end
end
