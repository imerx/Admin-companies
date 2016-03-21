class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name
      t.date :due_date
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
