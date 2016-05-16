class OrdersController < ApplicationController
  
  #before_action :all_tasks, only: [:index, :create]
  #respond_to :html, :js


  def new
    
    if params[:search]
      @products = Product.search(params[:search]).order("created_at DESC")
    else
      @products = Product.all.order('created_at DESC')
    end
     
     @cart = current_cart

 
    @order = Order.new
 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
      format.js   
    end
  end
  
  def create
    
    @order = Order.new(params[:order], order_params )
    @order.add_line_items_from_cart(current_cart)
 
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to(orders_url, :notice => 
          'Thank you for your order.') }
        format.xml  { render :xml => @order, :status => :created,
          :location => @order }
      else
        @cart = current_cart
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors,
          :status => :unprocessable_entity }
      end
    end
  end
    
  def search 
    @product = Product.search(params[:search_param]) 
  end
    # search product  in index

def index
  @orders = Order.all
  #@products = Product.all
  if params[:search]
    @products = Product.search(params[:search]).order("created_at DESC")
  else
    @products = Product.all.order('created_at DESC')
  end
  
    #@products = Product.order(:name)
    @cart = current_cart
end

  def destroy
  	@order = Order.find(params[:id])
    @order.destroy
    flash[:notice] = "order succesfully deleted"
    respond_to do |format|
      format.html { redirect_to orders_path(@company) }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end


   private
    def order_params
      params.require(:order).permit(:check_out_at,:company_id, :user_id)
    end
  
  
  
  
  
end   

