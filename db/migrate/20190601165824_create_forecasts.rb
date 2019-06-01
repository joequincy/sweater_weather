class CreateForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|
      t.references :location
      t.integer :type
      t.text :summary
      t.text :icon, limit: 30
      t.json :data
      t.timestamp :effective_time

      t.timestamps
    end
  end
end
