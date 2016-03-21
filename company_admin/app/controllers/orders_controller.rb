class OrdersController < ApplicationController
    
    def new
       @orders = Product.all
    end
    def index
    end
    
    
    
    
end