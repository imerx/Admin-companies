class Product < ActiveRecord::Base
    
    validates :name,:price, presence: true

    belongs_to :company

    has_many :line_items
    has_many :orders, :through => :line_items

    
end