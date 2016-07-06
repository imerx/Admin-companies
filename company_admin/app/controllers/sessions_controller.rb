class SessionsController < ApplicationController
    
    def new
    
    end
    
    def create
      user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])

         session[:user_id] = user.id      
         flash[:success] = "Acceso Exitoso"
            redirect_to companies_url
         else
             # add  falsh message to inform something wrong
             flash.now[:danger] = "Algo Estubo mal con la informacion , intente de nuevo"
             render 'new'
        end
    end
    
   def destroy   
     session[:user_id] = nil
     flash[:success] = "Has salido Sistema"
     render 'new'
   end


end