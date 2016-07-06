class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # the method created in application controller are available in all your controllers
  #but not available in your views for default
  
  helper_method :current_user , :logged_in?
      
      
    # code  for return @current_user if exist , if not (||=) find the user int the current session
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    #if current_user is true convert in a boolean (true or false) using then then (!!)
    def logged_in?
      !!current_user
    end
    # check if user is not loged in using  (!) if not
    def require_user
      if !logged_in?
      flash[:danger] = "Debes loguearte "
      render 'new'
      end
    end
  
  
  
  private
 
    def current_cart 
      Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end


end
