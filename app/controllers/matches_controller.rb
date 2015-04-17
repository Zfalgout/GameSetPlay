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

	def edit
		@match = Match.find(params[:id])
		@player1 = User.find_by(id: @match.player1)
		@player2 = User.find_by(id: @match.player2)
		@player3 = User.find_by(id: @match.player3)
		@player4 = User.find_by(id: @match.player4)
	end

	def join
		@match = Match.find_by(id: params[:id])
	end

	def update
    @match = Match.find(params[:id])
	    if @match.update_attributes(match_params)
	      flash[:success] = "Scores updated"
	      redirect_to root_url
	    else
	      render 'edit'
	    end
	end

	def create
	  @match = Match.new(match_params)

	  #Set the variables.
	  @name = @match.player2
	  @player2 = User.find_by(name: "#{@name}")
	  
	  @name3 = @match.player3
	  @player3 = User.find_by(name: "#{@name3}")
	  
	  @name4 = @match.player4
	  @player4 = User.find_by(name: "#{@name4}")
	  
	  @location = @match.location
	  @game_type = @match.game_type
	  @open = @match.open
	  @time = @match.time

	  #Do not allow a match between a user and itslef.
	  if (@player2 == current_user || (( @player3 == current_user || @player4 == current_user) && @game_type == "Doubles"))
	  	flash[:danger] = "You cannot play yourself."
	  	@match.destroy
	  	redirect_to root_url
	  elsif (@player2 == nil && @player3 == nil && @player4 == nil && @open == 0 && @game_type == "Doubles")  #Ensure the user exists in the database.
	  	flash[:danger] = "You must enter other players to create a private doubles match."
	  	@match.destroy
	  	redirect_to root_url
	  elsif (@player2 == nil && @player3 == nil && @open == 0 && @game_type == "Doubles")  #Ensure the user exists in the database.
	  	flash[:danger] = "You must enter a partner and another opponent to create a private doubles match."
	  	@match.destroy
	  	redirect_to root_url
	  elsif (@player2 == nil && @open == 0 && @game_type == "Doubles")  #Ensure the user exists in the database.
	  	flash[:danger] = "Player 2 was not found in our database."
	  	@match.destroy
	  	redirect_to root_url
	  elsif (@player3 == nil && @open == 0 &&@game_type == "Doubles")  #Ensure the user exists in the database.
	  	flash[:danger] = "Player 3 was not found in our database."
	  	@match.destroy
	  	redirect_to root_url
	  elsif (@player4 == nil && @open == 0 && @game_type == "Doubles")  #Ensure the user exists in the database.
	  	flash[:danger] = "Player 4 was not found in our database."
	  	@match.destroy
	  	redirect_to root_url
	  elsif (@player2 == nil && @open == 0)  #Ensure the user exists in the database.
	  	flash[:danger] = "Your opponent was not found in our database."
	  	@match.destroy
	  	redirect_to root_url
	  elsif (@player2 == nil && @name != 'Player 2' && @open == 1 && @game_type == "Doubles")  #Ensure the user exists in the database.
	  	flash[:danger] = "Player 2 was not found in our database."
	  	@match.destroy
	  	redirect_to root_url
	  elsif (@player3 == nil && @name3 != 'Player 3' && @open == 1 &&@game_type == "Doubles")  #Ensure the user exists in the database.
	  	flash[:danger] = "Player 3 was not found in our database."
	  	@match.destroy
	  	redirect_to root_url
	  elsif (@player4 == nil && @name4 != 'Player 4' && @open == 1 && @game_type == "Doubles")  #Ensure the user exists in the database.
	  	flash[:danger] = "Player 4 was not found in our database."
	  	@match.destroy
	  	redirect_to root_url
	  
	  #Create different match types based on the user input.
	  #Singles/Private
	  elsif (@game_type == "Singles" && @open == 0) 
	  	@match = current_user.challenge(@player2, @location, @game_type, @open, @time) 
			
			if @match.save  #match creation
			#Email Setup
		    #@match.send_email
		    flash[:info] = "Your opponent has been notified."
		    redirect_to root_url
		    else
		      @match.player2 = @name
			  render 'new' #In case of errors.
		    end
	   
	   #Singles/Public 
	   elsif (@game_type == "Singles" && @open == 1)
	   	@match = current_user.open_challenge(@location, @game_type, @open, @time)
       		
       		if @match.save  #match creation
			#Email Setup
		    #@match.send_email
		    flash[:info] = "Your match has been created."
		    redirect_to root_url
		    else
			  render 'new' #In case of errors.
		    end

       #Doubles/Private  
	   elsif (@game_type == "Doubles" && @open == 0)
		   	@match = current_user.doubles_challenge(@player2, @player3, @player4, @location, @game_type, @open, @time)

		   		if @match.save  #match creation
			   		#Email Setup
				    #@match.send_email
				    flash[:info] = "Your partner and opponents have been notified."
				    redirect_to root_url
			    else
			      @match.player2 = @name
			      @match.player3 = @name3
			      @match.player4 = @name4
				  render 'new' #In case of errors.
			    end
		
	   #Doubles/Public  
	   elsif (@game_type == "Doubles" && @open == 1)

	   		@match.player1 = current_user.id

	   		if (@match.player2 == 'Player 2' && @match.player3 == 'Player 3' && @match.player4 == 'Player 4')
		   	
		   		@match = current_user.open_challenge(@location, @game_type, @open, @time)

		   	elsif (@match.player2 != 'Player 2' && @match.player3 == 'Player 3' && @match.player4 == 'Player 4')

		   		@match = current_user.open_challenge_with_partner(@player2, @location, @game_type, @open, @time)

		   	elsif (@match.player2 == 'Player 2' && @match.player3 != 'Player 3' && @match.player4 == 'Player 4')

		   		@match = current_user.open_challenge_one_opponent(@player3, @location, @game_type, @open, @time)

		   	elsif (@match.player2 == 'Player 2' && @match.player3 == 'Player 3' && @match.player4 != 'Player 4')

		   		@match = current_user.open_challenge_one_opponent(@player4, @location, @game_type, @open, @time)

		    elsif (@match.player2 != 'Player 2' && @match.player3 != 'Player 3' && @match.player4 == 'Player 4')

		    	@match = current_user.open_challenge_with_partner_and_opponent(@player2, @player3, @location, @game_type, @open, @time)
		    
		    elsif (@match.player2 != 'Player 2' && @match.player3 == 'Player 3' && @match.player4 != 'Player 4')

		    	@match = current_user.open_challenge_with_partner_and_opponent(@player2, @player4, @location, @game_type, @open, @time)
		    
		    elsif (@match.player2 == 'Player 2' && @match.player3 != 'Player 3' && @match.player4 != 'Player 4')

		    	@match = current_user.open_challenge_with_opponents(@player3, @player4, @location, @game_type, @open, @time)

		    elsif (@match.player2 != 'Player 2' && @match.player3 != 'Player 3' && @match.player4 != 'Player 4')
		    
		    	@match = current_user.doubles_challenge(@player2, @player3, @player4, @location, @game_type, @open, @time)

		    end
		   		
		   		if @match.save  #match creation
					#Email Setup
				    #@match.send_email
				    flash[:info] = "Your match has been created."
				    redirect_to root_url
				   else
					  render 'new' #In case of errors.
			    end
		  	
	   end
    end

def open
	#@singlesMatches = Match.where(open: 1, game_type: 'Singles', player2: 'Player 2', time: Date.today..3.years.from_now).where.not(player1: current_user.id).all.paginate(page: params[:page])
	#@doublesMatches = Match.where("open = ? AND game_type = ? OR player2 = ? OR player3 = ? OR player4 = ?", 1, 'Doubles', 'Player 2', 'Player 3', 'Player 4').where.not(player1: current_user.id, player2: current_user.id, player3: current_user.id, player4: current_user.id).where(time: Date.today..3.years.from_now).all.paginate(page: params[:page])
	if params[:search]
		@matches = Match.search(params[:search]).where("open = ? AND player2 = ? OR player3 = ? OR player4 = ?", 1, 'Player 2', 'Player 3', 'Player 4').where.not(player1: current_user.id, player2: current_user.id, player3: current_user.id, player4: current_user.id).where(time: Date.today..3.years.from_now).all.paginate(page: params[:page])
	else
		@matches = Match.where("open = ? AND player2 = ? OR player3 = ? OR player4 = ?", 1, 'Player 2', 'Player 3', 'Player 4').where.not(player1: current_user.id, player2: current_user.id, player3: current_user.id, player4: current_user.id).where(time: Date.today..3.years.from_now).all.paginate(page: params[:page])
	end

end

def destroy
    @match = Match.find(params[:id])
    @userID = @match.player1
    @user = User.find_by(id: "#{@userID}")
    @match.destroy
    flash[:success] = "Match deleted"
    redirect_to @user
  end

private

	def match_params
      params.require(:match).permit(:player1, :player2, :player3, :player4, :location,
                                   :time, :game_type, :open, :winner, :loser, :score)
    end
end
