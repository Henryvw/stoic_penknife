# frozen_string_literal: true

class RenameMeditationToQuotation < ActiveRecord::Migration[5.0]
  def change
    rename_table :meditations, :quotations
  end
end
