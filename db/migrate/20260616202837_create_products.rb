class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :amount
      t.integer :min
      t.decimal :price
      t.integer :status
      t.uuid :sku

      t.timestamps
    end
  end
end
