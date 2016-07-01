class OrdersController < ApplicationController
  
  def index
    @line_items = LineItem.all
    @company = Company.find(params[:company_id])     
    #@orderss = Order.all.order("created_at DESC").limit(5) 
    
   case  # was case obj.class
      when params[:q] ==="all"
          @orders = Order.limit(100).order("created_at DESC").paginate(:page => params[:page],:per_page => 10)
      when params[:q] ==="semanal"
          @orders = Order.current_week.paginate(:page => params[:page], :per_page => 10)
      when params[:q] === "mensual"
          @orders = Order.current_month.paginate(:page => params[:page], :per_page => 10)
      else
          @orders = Order.current_day.paginate(:page => params[:page], :per_page => 10)
   end
  end   
   
  def search
    if params[:search]
      @products = Product.search(params[:search]).order("created_at DESC").limit(2) 
    else
      redirect_to company_path(@company)
    end   
  end

  def new       
    @order = Order.new
    #@company = Company.find(params[:company_id])
    @cart = current_cart   
    
    

  end
  
  def show    
    @line_items = LineItem.all
    @order = Order.find(params[:id])
     respond_to do |format|
      format.js
    end
  end
  

  def create
    
   @order = Order.create(order_params)
   @order.add_line_items_from_cart(current_cart)
   
    
   respond_to do |format|
    if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
       # format.html { redirect_to(orders_url, :notice => 
         # 'Thank you for your order.') }
        #format.xml  { render :xml => @order, :status => :created,
        #  :location => @order }
        format.js
       else
        @cart = current_cart
        
        format.html {redirect_to (companies_path) }#render :action => "new" }
       # format.xml  { render :xml => @order.errors,
         # :status => :unprocessable_entity }
    end
    end
  end


  def destroy
  	@order = Order.find(params[:id])
    if  @order.destroy

    flash[:notice] = "Order succesfully deleted"
    respond_to do |format|
      format.html { redirect_to orders_path(@company) }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
    end
  end
    
  
  private
    def order_params
      params.require(:order).permit(:user_id,:company_id,:check_out_at, :total_price)
    end
end
