class AddAntipodeToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :address, :text
    add_column :locations, :antipode, :text
  end
end
