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
	  #@user.matches.paginate(page: params[:page])
	  @opponent = User.second
	  @location = @match.location
	  @game_type = @match.game_type
	  @open = @match.open
	  @time = @match.time

	  #Create the match with the given variables.
	  @match = current_user.challenge(@opponent, @location, @game_type, @open, @time)

	  #Do not allow a match between a user and itslef.
	  if (@opponent == current_user)
	  	flash[:danger] = "You cannot play yourself."
	  	@match.destroy
	  	redirect_to root_url
	  elsif @match.save  #match creation
		#Email Setup
	    #@match.send_email
	    flash[:info] = "Your opponent has been notified."
	    redirect_to root_url
	  else
	    render 'new' #In case of errors.
      end
    end

private

	def match_params
      params.require(:match).permit(:player1, :player2, :location,
                                   :time, :game_type, :open)
    end
end
