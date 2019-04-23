class AddPublishToQuotations < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :publish, :boolean
  end
end
