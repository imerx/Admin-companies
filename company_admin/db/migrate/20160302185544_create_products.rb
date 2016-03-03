class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code
      t.integer :quantity
      t.decimal :cost
      t.decimal :price
      t.text :description
      t.string :image
      t.datetime :created_at
      t.datetime :updated_at
      end
  end
end
