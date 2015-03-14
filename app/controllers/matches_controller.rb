class MatchesController < ApplicationController
	
	def new
  	  @match = Match.new
    end

    def index
	   @matches = Match.paginate(page: params[:page])
	end

	def show
	  @match = Match.find_by(id: params[:id])
	end

	def create
	  @match = Match.new(match_params)

	  #Set the variables.
	  @name = @match.player2
	  @opponent = User.find_by(name: "#{@name}")
	  @location = @match.location
	  @game_type = @match.game_type
	  @open = @match.open
	  @time = @match.time

	  #Do not allow a match between a user and itslef.
	  if (@opponent == current_user)
	  	flash[:danger] = "You cannot play yourself."
	  	@match.destroy
	  	redirect_to root_url
	  elsif (@opponent == nil)  #Ensure the user exists in the database.
	  	flash[:danger] = "That user was not found in our database."
	  	@match.destroy
	  	redirect_to root_url
	  else
	  #Create the match with the given variables.
	  @match = current_user.challenge(@opponent, @location, @game_type, @open, @time)
		
		if @match.save  #match creation
		#Email Setup
	    #@match.send_email
	    flash[:info] = "Your opponent has been notified."
	    redirect_to root_url
	    else
	      @match.player2 = @name
		  render 'new' #In case of errors.
	    end
      end
    end

private

	def match_params
      params.require(:match).permit(:player1, :player2, :location,
                                   :time, :game_type, :open)
    end
end
