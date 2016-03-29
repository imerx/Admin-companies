class Expense < ActiveRecord::Base
    
  has_many :payments
  has_many :payments, :through => :companies


end