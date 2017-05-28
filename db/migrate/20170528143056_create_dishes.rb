class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.string :dish
      t.float :price
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
