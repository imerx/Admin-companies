class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

 
  # GET /line_items/1
  # GET /line_items/1.json
  
  def show
    #@line_items = LineItem.all
    @line_item = LineItem.find(params[:id])
     respond_to do |format|
      format.js
    end
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end



  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    @line_item.product = product
 
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(orders_url) }
        format.js   { @current_item = @line_item }
        format.xml  { render :xml => @line_item,
          :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @line_item.errors,
          :status => :unprocessable_entity }
      end
    end
  end


   # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Tu  orden ha sido cancelado.' }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id)
    end
end
