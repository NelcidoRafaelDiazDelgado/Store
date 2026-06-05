class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.uuid :sku
      t.text :description
      t.decimal :price
      t.string :category
      t.integer :amount
      t.integer :min
      t.boolean :status

      t.timestamps
    end
  end
end
