class Order < ActiveRecord::Base
    
 # has_many :line_items, dependent: :destroy
  #has_many :products, :through => :line_items
  
  belongs_to :company
  has_many :line_items, :dependent => :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end


end