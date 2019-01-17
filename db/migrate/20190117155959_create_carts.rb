class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.string :name
      t.text :description
      t.integer :item_id
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity

      t.timestamps
    end
  end
end
