class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
