class SessionsController < ApplicationController

    def new
        @user = User.new
    end
    
    def create
        @user = User.find_by(name: params[:user][:name])
        #binding.pry
        if @user == nil || !@user.authenticate(params[:user][:password])
            flash[:notice] = "Unable to authenticate user."
            redirect_to signin_path
        else
            session[:user_id] = @user.id
            redirect_to user_path(@user)            
        end

    end
    
    def destroy
        #session.clear
        session.delete :user_id
        flash[:notice] = "You have signed out."
        redirect_to '/'
    end
    
end