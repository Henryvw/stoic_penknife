class CreateMeditations < ActiveRecord::Migration[5.2]
  def change
    create_table :meditations do |t|
      t.string :title
      t.text :passage

      t.timestamps
    end
  end
end
