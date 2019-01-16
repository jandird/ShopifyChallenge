class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :item_id
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
