class OrdersController < ApplicationController
  
  def index
    @orders = Order.all
    @cart = current_cart
    @products = Product.all
    #@company = Company.find(params[:company_id])
    
  end

  def new    
    
    @order = Order.new
    #@company = Company.find(params[:company_id])
    @products = Product.all   
    @cart = current_cart
    
  end
  
  def search
    if params[:search]
      @products = Product.search(params[:search]).order("created_at DESC").limit(2)
 
    else
      redirect_to company_path(@company)
    end   
  end

  def create
    
    #@order = Order.new(params[:order], order_params )
    @order = Order.create(order_params)
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


  def destroy
  	@order = Order.find(params[:id])
    @order.destroy
    flash[:notice] = "Order succesfully deleted"
    respond_to do |format|
      format.html { redirect_to orders_path(@company) }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end
    
  
  private
    def order_params
      params.require(:order).permit(:user_id,:check_out_at, :total_price)
    end
end
