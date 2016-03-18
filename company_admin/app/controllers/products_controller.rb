class ProductsController < ApplicationController
  def index
    @products = Product.all
    @company = Company.find(params[:company_id])
  end

  def new
    @product = Product.new
    @company = Company.find(params[:company_id])
  end

  def create
    @product = Product.create(product_params)
    @product.company = Company.first
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.update(params[:id], product_params)
  end
  
  def destroy
  	@product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Product succesfully deleted"
    respond_to do |format|
      format.html { redirect_to products_path(@company) }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end
  
  private
    def product_params
      params.require(:product).permit(:code,:name, :price,:quantity,:cost,:description,:image,:company_id)
    end
end
