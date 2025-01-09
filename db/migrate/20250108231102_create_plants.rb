class CreatePlants < ActiveRecord::Migration[8.0]
  def change
    create_table :plants do |t|
      t.string :name
      t.text :img_url
      t.text :description

      t.timestamps
    end
  end
end
