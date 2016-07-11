class Order < ActiveRecord::Base
  
    before_save { self.total_price = total_price }  

  #has_many :products, :through => :line_items
  
  belongs_to :company
  has_many :line_items, :dependent => :destroy
  
  #  use scope  to filter querys in orders
 scope :current_day, -> { where("created_at > ?", Time.zone.today).order("created_at desc") }
 
 scope :current_week, -> {
     start = Time.zone.now
     where(created_at: start.beginning_of_week..start.end_of_week).order("created_at desc")
     }
 scope :current_month, -> {
     start =Time.zone.now
     where(created_at: start.beginning_of_month..start.end_of_month).order("created_at desc")
     }
  #  This method is called  in order controller  action create  to save the items from  cart to lineitems

    def add_line_items_from_cart(cart)
        cart.line_items.each do |item|
          item.cart_id = nil
          line_items << item 
        end
    end
   #   Sum all   items    in lineitems to get the total  of sale
    def total_price
      line_items.to_a.sum { |item| item.total_price }
    end


end