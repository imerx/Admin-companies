# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


expense_list = ["Electricidad","Agua","Renta","Consumibles", "extinguidores","productos de Limpeza" , "otros gastos"]

expense_list.each do |name|
  Expense.create( name: name)
end