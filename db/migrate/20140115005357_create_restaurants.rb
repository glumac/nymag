class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.boolean :criticpick
      t.string :link
      t.text :description
      t.string :address
      t.text :cuisine
      t.string :price
      t.string :neighborhood
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
