class Company < ActiveRecord::Base
    validates :name, presence: true, length: {minimum: 3, maximum: 50}

     has_many :products
     has_many :orders 
     has_many :payments
     #has_many :payments, :through => :expenses
end