class AddPublishToQuotations < ActiveRecord::Migration[5.0]
  def change
    add_column :quotations, :publish, :boolean
  end
end
