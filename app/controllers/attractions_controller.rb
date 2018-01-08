class AttractionsController < ApplicationController
    skip_before_action :require_admin, only: [:index, :show, :ride]

    def ride
        @current_user = current_user
        @attraction = Attraction.find(params[:attraction_id])
        if @attraction.tickets > @current_user.tickets && @attraction.min_height > @current_user.height
            flash[:notice] = "You do not have enough tickets to ride the #{@attraction.name}. You are not tall enough to ride the #{@attraction.name}."
            redirect_to user_path(@current_user) 
        elsif @attraction.tickets > @current_user.tickets
            flash[:notice] = "You do not have enough tickets to ride the #{@attraction.name}"
            redirect_to user_path(@current_user) 
        elsif @attraction.min_height > @current_user.height
            flash[:notice] = "You are not tall enough to ride the #{@attraction.name}"
            redirect_to user_path(@current_user) 
        else
            @current_user.tickets -= @attraction.tickets
            @current_user.happiness += @attraction.happiness_rating
            @current_user.nausea += @attraction.nausea_rating
            @current_user.save
            @attraction.rides << Ride.new({user_id: @current_user.id,attraction_id: @attraction.id})
            @attraction.save
            flash[:notice] = "Thanks for riding the #{@attraction.name}!"
            redirect_to user_path(@current_user) 
        end
    end
    
    def index
        @attractions = Attraction.all
        @current_user = current_user
    end

    def new
        @attraction = Attraction.new
    end

    def create
        attraction = Attraction.new(attraction_params)
        
        if attraction.save
            #binding.pry
            redirect_to attraction_path(attraction)
        else
            #some kind of message
            redirect_to '/attractions/new'
        end   
    end
  
    def edit
        @attraction = Attraction.find(params[:id])
    end
   
    def update
        @attraction = Attraction.find(params[:id])
        @attraction.update(attraction_params)
        if @attraction.save
            #binding.pry
            redirect_to attraction_path(@attraction)
        else
            #some kind of message
            redirect_to edit_attraction_path(@attraction)
        end
    end
   
    def show
        @attraction = Attraction.find(params[:id])
        @current_user = current_user
    end
    
    private
    
    def attraction_params
      params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
    end
    
      private
 
    def require_admin
        unless current_user && current_user.admin == true
            flash[:notice] = "You must be an admin user to access this section"
            redirect_to attractions_path # halts request cycle
        end
    end
    

    
end