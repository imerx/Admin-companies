class PaymentsController < ApplicationController
    

  def index
    @payments = Payment.all
    @company = Company.find(params[:company_id])
    
  end

  def new
    @payment = Payment.new
    @company = Company.find(params[:company_id])
  end

  def create
    @payment = Payment.create(payment_params)
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.update(params[:id], payment_params)
  end
  
  
  def destroy
  	@payment = Payment.find(params[:id])
    @payment.destroy
    flash[:notice] = "Product succesfully deleted"
    respond_to do |format|
      format.html { redirect_to payments_path(@company) }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  
  private
    def payment_params
      params.require(:payment).permit(:amount, :status,:expense_id,:company_id)
    end
    
    
    
end