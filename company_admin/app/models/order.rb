class Order < ActiveRecord::Base
  
      

 # has_many :line_items, dependent: :destroy
  #has_many :products, :through => :line_items
  
  belongs_to :company
  has_many :line_items, :dependent => :destroy
  
  
 scope :current_day, -> { where("created_at > ?", Date.today).order("created_at desc") }
 
 scope :current_week, -> {
     start = Time.zone.now
     where(created_at: start.beginning_of_week..start.end_of_week).order("created_at desc")
     }
 scope :current_month, -> {
     start =Time.zone.now
     where(created_at: start.beginning_of_month..start.end_of_month).order("created_at desc")
     }
  #  method calling in order controller  action create

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item 
    end
  end
    def total_price
      line_items.to_a.sum { |item| item.total_price }
    end


end