class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.date :due_date
      t.boolean :status
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
