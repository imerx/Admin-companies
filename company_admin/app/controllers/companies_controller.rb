class CompaniesController < ApplicationController


def index
	@companies = Company.all

	@today_sales = Order.current_day.sum(:total_price) 
 
end
# this action fire details sales in 
def sales_info
    
    ### Incomes ###
    @orders = Order.current_week
    @today_sales = Order.current_day.sum(:total_price) 
	@week_sales = Order.current_week.sum(:total_price) 
	@month_sales = Order.current_month.sum(:total_price) 
	
	###  Payments,expenses###
	@week_expenses = Payment.current_week
	
end

def payments_info
    
end

def show
	@company = Company.find(params[:id])
#	@company.records.build
end
def new
    @company = Company.new
end
def edit
   @company = Company.find(params[:id]) 
end
def create
    @company = Company.new(company_params)
    if @company.save
        flash[:notice] = "Company was succesfully created"
        redirect_to company_path(@company)
    else
        render 'new'
    end
end
def update
   @company = Company.find(params[:id])
   if @company.update(company_params)
       flash[:notice] = "Company succesfully updated"
       redirect_to company_path(@company)
       else
       render 'edit' 
   end
end
def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:notice] = "Company succesfully deleted"
        redirect_to company_path(@company)
end

private

def company_params
    params.require(:company).permit(:name)
end




end