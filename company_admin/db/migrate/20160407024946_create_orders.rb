class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.decimal  "total_price",    :precision => 8, :scale => 2, :default => 0.0
      t.datetime :check_out_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
