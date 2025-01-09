class CreateGardens < ActiveRecord::Migration[8.0]
  def change
    create_table :gardens do |t|
      t.string :name
      t.string :hardiness_zone
      t.string :sunlight
      t.string :soil_type
      t.string :water_needs
      t.string :purpose

      t.timestamps
    end
  end
end
