class RenameMeditationToQuotation < ActiveRecord::Migration[5.2]
  def change
    rename_table :meditations, :quotations
  end
end
