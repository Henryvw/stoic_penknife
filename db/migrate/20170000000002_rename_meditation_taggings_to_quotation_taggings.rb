class RenameMeditationTaggingsToQuotationTaggings < ActiveRecord::Migration[5.0]
  def change
    rename_table :meditation_taggings, :quotation_taggings
  end
end
