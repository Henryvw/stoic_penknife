class CreateDoctrines < ActiveRecord::Migration[5.2]
  def change
    create_table :doctrines do |t|
      t.string :file_name

      t.timestamps
    end
  end
end
