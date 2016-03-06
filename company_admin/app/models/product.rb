class Product < ActiveRecord::Base
    
    validates :name,:price, presence: true

    belongs_to :company


    
end