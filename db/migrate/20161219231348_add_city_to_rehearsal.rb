class AddCityToRehearsal < ActiveRecord::Migration[5.2]
  def change
    add_column :rehearsals, :city, :string
  end
end
