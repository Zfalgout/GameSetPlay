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
	  #@user = User.find_by(name: params[:player2])
	  #@user = User.find_by(name: [match.player2]).id
	  @user = User.fourth
	  @location = @match.location
	  #@location = "the court"
	  @game_type = @match.game_type
	  @open = @match.open
	  @time = @match.time
	  #current_user.matches.create!(match_params)
	  @match = current_user.challenge(@user, @location, @game_type, @open, @time)
	  #@match = Match.new(match_params)
	  #@match.player1 = session[:user_id]
	  #@match.user_id = session[:user_id]
	  if @match.save
		#Email Setup
	    #@match.send_email
	    flash[:info] = "Your opponent has been notified."
	    redirect_to root_url
	  else
	    render 'new'
      end
    end

private

	def match_params
      params.require(:match).permit(:player1, :player2, :location,
                                   :time, :game_type, :open)
    end
end
