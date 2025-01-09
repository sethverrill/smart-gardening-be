class CreateGardenPlants < ActiveRecord::Migration[8.0]
  def change
    create_table :garden_plants do |t|
      t.references :garden, null: false, foreign_key: true
      t.references :plant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
