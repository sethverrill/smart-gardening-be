class AddZipCodeToGardens < ActiveRecord::Migration[8.0]
  def change
    add_column :gardens, :zip_code, :string
  end
end
