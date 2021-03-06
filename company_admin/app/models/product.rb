class Product < ActiveRecord::Base
    
    validates :name,:price, presence: true

    belongs_to :company

    has_many :line_items
    has_many :orders, :through => :line_items

 
     before_destroy :ensure_not_referenced_by_any_line_item
     
     


    
def self.search(search)
  # Title is for the above case, the OP incorrectly had 'name'
   where("name LIKE ?", "%#{search}%")
   where("code LIKE ?", "%#{search}%") 
end

   private
 
    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
 
    
end