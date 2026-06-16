class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :sku
      t.integer :minimum
      t.integer :amount
      t.boolean :status

      t.timestamps
    end
  end
end
