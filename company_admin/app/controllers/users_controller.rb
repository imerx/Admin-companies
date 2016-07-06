class UsersController < ApplicationController
  
  # Warning  -- before action work in order  in order according to your actions
    before_action :set_user, only: [:edit, :update, :show]
    before_action :required_admin, only: [:destroy]
    
    
    def index
      @users = User.all
    end
    
    def new
      @user = User.new
    end
    
    def create
      @user = User.new(user_params)
      session[:user_id] = User.id
    end
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "El  Usuario a sido borrado"
        respond_to do |format|
          format.html { redirect_to users_path }
          format.json { head :no_content }
          format.js   { render :layout => false }
        end
    end
        
    
    private
    
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    # set the user to be ready only for action specified above  if  use in a future
    def set_user
      @user = User.find(params[:id])
    end
        # required if user is not an admin
    def is_not_admin
      if current_user != @user and !current_user.admin?
      flash[:danger] = "Debes loguearte "
      render 'new'
      end
    end
    # required destroy  (order, users) if  user not admin
    def required_admin
      if logged_in? and !current_user.admin?
      flash[:danger] = "Solo el Administrador puede realizar esta accion "
      render 'new'
      end
      
    end


end

