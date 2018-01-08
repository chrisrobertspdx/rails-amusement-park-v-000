class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        user = User.new(user_params)
        
        if user.save
            #binding.pry
            
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            #some kind of message
            redirect_to '/users/new'
        end   
    end
 
    def edit
        @user = User.find(session[:user_id])
    end
   
    def update
        #binding.pry
        @user = User.find(params[:id])
        
        @user.update(user_params)
        if @user.save
            #binding.pry
            redirect_to user_path(@user)
        else
            #some kind of message
            redirect_to edit_user_path(@user)
        end
    end
 
 
    def show
        #require_login
        #is_admin
        #binding.pry
        if logged_in?
            @user = User.find(session[:user_id])
        else
            redirect_to '/'
        end
    end
    
    def user_params
      params.require(:user).permit(:name, :height, :tickets, :happiness, :nausea, :admin, :password)
    end
    

    
end