class CreateRehearsals < ActiveRecord::Migration
  def change
    create_table :rehearsals do |t|
      t.integer :tally

      t.timestamps
    end
  end
end
