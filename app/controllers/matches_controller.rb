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

	def challenges
		@user = User.find_by(id: current_user.id)
		@matches = Match.where("p2Active = ? AND player2 = ? OR p3Active = ? AND player3 = ? OR p4Active = ? AND player4 = ?", 0, "#{current_user.id}", 0, "#{current_user.id}", 0, "#{current_user.id}",).paginate(page: params[:page])
	end

	def update
    @match = Match.find(params[:id])
    @id = params[:id]
    @player1 = User.find_by(id: @match.player1)
	@player2 = User.find_by(id: @match.player2)
	@player3 = User.find_by(id: @match.player3)
	@player4 = User.find_by(id: @match.player4)

	    if (@match.update_attributes(match_params))

	    	if (@match.player2 != "Player 2" && @match.player3 != "Player 3" && @match.player4 != "Player 4")
	    		activatePlayers(@id)
	    	end

		    	if (@match.game_type == "Singles" && @player2 != nil && @match.time < Time.now) #Have to differentiate between singles and doubles matches.
					if (@match.scoreValid == 1 && @match.validated == 3) #send an email to the other player requesting validation.
						
						if (@player1.id == current_user.id)
							@match.validator1 == @player2.id
							@match.send_validation_email(@player2, @match) # email sent
							flash[:success] = "Your opponent has been notified."
						else
							@match.validator1 == @player1.id
							@match.send_validation_email(@player1, @match) #email sent
							flash[:success] = "Your opponent has been notified."
						end

					elsif (@match.scoreValid == 4 && @match.validator1 == current_user.id)  #The scores entered are valid
							if (@match.validated == 1)
							    if (@match.winner == @player1.name) #Player one is the winner
							    	updateWinner(@match.player1)
							    	updateLoser(@match.player2)
							    	flash[:success] = "Scores updated. Congratulations #{@match.winner}!!"
							    else #Player two is the winner.
							    	updateWinner(@match.player2)
							    	updateLoser(@match.player1)
							    	flash[:success] = "Scores updated. Congratulations #{@match.winner}!!"
							    end
							elsif (@match.validated == 0)
								#Send an email to the both players and increase both player's invalid score count by one.
								@match.send_invalid_score_email(@player1, @match) #email sent
								@match.send_invalid_score_email(@player2, @match) #email sent
								updateInvalids(@match.player1)
								updateInvalids(@match.player2)
								flash[:danger] = "Your opponent has been notified of the invalid scores."
							end	
						
					end
				elsif (@match.game_type == "Doubles" && @player2 != nil && @player3 != nil && @player4 != nil && @match.time < Time.now)

					if (@match.scoreValid == 1 && @match.validated == 3) #send an email to the other players requesting validation.
						#set @match.validator to each other player's id.
						if (@player1.id == current_user.id)
							@match.validator1 == @player2.id
							@match.validator2 == @player3.id
							@match.validator3 == @player4.id
							@match.send_validation_email(@player2, @match) #email sent
							@match.send_validation_email(@player3, @match) #email sent
							@match.send_validation_email(@player4, @match) #email sent
							flash[:success] = "Your opponents have been notified."
						elsif (@player2.id == current_user.id)
							@match.validator1 == @player1.id
							@match.validator2 == @player3.id
							@match.validator3 == @player4.id
							@match.send_validation_email(@player2, @match) #email sent
							@match.send_validation_email(@player3, @match) #email sent
							@match.send_validation_email(@player4, @match) #email sent
							flash[:success] = "Your opponents have been notified."
						elsif (@player3.id == current_user.id)
							@match.validator1 == @player2.id
							@match.validator2 == @player1.id
							@match.validator3 == @player4.id
							@match.send_validation_email(@player2, @match) #email sent
							@match.send_validation_email(@player3, @match) #email sent
							@match.send_validation_email(@player4, @match) #email sent
							flash[:success] = "Your opponents have been notified."
						elsif (@player4.id == current_user.id)
							@match.validator1 == @player2.id
							@match.validator2 == @player3.id
							@match.validator3 == @player1.id
							@match.send_validation_email(@player2, @match) #email sent
							@match.send_validation_email(@player3, @match) #email sent
							@match.send_validation_email(@player4, @match) #email sent
							flash[:success] = "Your opponents have been notified."
						end
					elsif (@match.scoreValid == 4 && (@match.validator1 == current_user.id || @match.validator2 == current_user.id || @match.validator3 == current_user.id)) #The scores entered are valied
						if (@match.validated == 1)
							if (@match.winner == "#{@player1.name} & #{@player2.name}") #The creator of the match and his or her partner won.
								updateWinner(@match.player1)
								updateWinner(@match.player2)
								updateLoser(@match.player3)
								updateLoser(@match.player4)
								flash[:success] = "Scores updated. Congratulations #{@match.winner}!!"
							else #The opponents won.
								updateWinner(@match.player4)
								updateWinner(@match.player3)
								updateLoser(@match.player2)
								updateLoser(@match.player1)
								flash[:success] = "Scores updated. Congratulations #{@match.winner}!!"
							end
						elsif (@match.validated == 0)
							# Send an email to the match creator and increase all player's invalid score count by one.
							@match.send_invalid_score_email(@player1, @match) #email sent
							@match.send_invalid_score_email(@player2, @match) #email sent
							@match.send_invalid_score_email(@player3, @match) #email sent
							@match.send_invalid_score_email(@player4, @match) #email sent
							updateInvalids(@match.player1)
							updateInvalids(@match.player2)
							updateInvalids(@match.player3)
							updateInvalids(@match.player4)
							flash[:danger] = "The other players have been notified of the invalid scores."
						end
					end
				elsif (@match.player2Accept == 0 || @match.player3Accept == 0 || @match.player4Accept == 0)
					flash[:danger] = "You have declined the challenge.  The match creator has been notified."
					@match.send_decline_email(@player1, @match)

				elsif (@match.player2 == @match.player3)
	    			flash[:danger] = "You cannot join as both a partner and an opponent."
	    			fixPlayers1(@match)
	    		elsif (@match.player2 == @match.player4)
	    			flash[:danger] = "You cannot join as both a partner and an opponent."
	    			fixPlayers2(@match)
				elsif (@match.time > Time.now)
					flash[:success] = "You have been added to the match!  Good luck!"
			end
	   
	      redirect_to root_url
	    else

	      render 'edit'
	    end
	end

	def create
	  @match = Match.new(match_params)
	  @player1 = current_user

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
	  @zip = @match.zip

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
	  	@match = current_user.challenge(@player2, @location, @game_type, @open, @time, @zip) 
			@match.player3 = ""
			@match.player4 = ""
			@match.p3Active = 1
			@match.p4Active = 1
			if @match.save  #match creation
			#Email Setup
		    @match.send_challenge_email(@player2, @match, @player1)
		    flash[:info] = "Your opponent has been notified."
		    redirect_to root_url
		    else
		      @match.player2 = @name
			  render 'new' #In case of errors.
		    end
	   
	   #Singles/Public 
	   elsif (@game_type == "Singles" && @open == 1)
	   	@match = current_user.open_challenge(@location, @game_type, @open, @time, @zip)
       		@match.player3 = ""
       		@match.player4 = ""
       		@match.p3Active = 1
			@match.p4Active = 1
       		if @match.save  #match creation
			#No email since it is an open match.
		    flash[:info] = "Your match has been created."
		    redirect_to root_url
		    else
			  render 'new' #In case of errors.
		    end

       #Doubles/Private  
	   elsif (@game_type == "Doubles" && @open == 0)
		   	@match = current_user.doubles_challenge(@player2, @player3, @player4, @location, @game_type, @open, @time, @zip)

		   		if @match.save  #match creation
			   		#Email Setup
				    @match.send_challenge_email(@player2, @match, @player1)
				    @match.send_challenge_email(@player3, @match, @player1)
				    @match.send_challenge_email(@player4, @match, @player1)
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
		   	
		   		@match = current_user.open_challenge(@location, @game_type, @open, @time, @zip)

		   		if @match.save  #match creation
					#No email because there are no opponents.
				    flash[:info] = "Your match has been created."
				    redirect_to root_url
				   else
					  render 'new' #In case of errors.
			    end

		   	elsif (@match.player2 != 'Player 2' && @match.player3 == 'Player 3' && @match.player4 == 'Player 4')

		   		@match = current_user.open_challenge_with_partner(@player2, @location, @game_type, @open, @time, @zip)

		   		if @match.save  #match creation
					#Email Setup
				    @match.send_challenge_email(@player2, @match, @player1)
				    flash[:info] = "Your partner has been notified"
				    redirect_to root_url
				   else
					  render 'new' #In case of errors.
			    end

		   	elsif (@match.player2 == 'Player 2' && @match.player3 != 'Player 3' && @match.player4 == 'Player 4')

		   		@match = current_user.open_challenge_one_opponent(@player3, @location, @game_type, @open, @time, @zip)

		   		if @match.save  #match creation
					#Email Setup
				    @match.send_challenge_email(@player3, @match, @player1)
				    flash[:info] = "Your opponent has been notified."
				    redirect_to root_url
				   else
					  render 'new' #In case of errors.
			    end

		   	elsif (@match.player2 == 'Player 2' && @match.player3 == 'Player 3' && @match.player4 != 'Player 4')

		   		@match = current_user.open_challenge_one_opponent(@player4, @location, @game_type, @open, @time, @zip)

		   		if @match.save  #match creation
					#Email Setup
				    @match.send_challenge_email(@player4, @match, @player1)
				    flash[:info] = "Your opponent has been notified"
				    redirect_to root_url
				   else
					  render 'new' #In case of errors.
			    end

		    elsif (@match.player2 != 'Player 2' && @match.player3 != 'Player 3' && @match.player4 == 'Player 4')

		    	@match = current_user.open_challenge_with_partner_and_opponent(@player2, @player3, @location, @game_type, @open, @time, @zip)

		    	if @match.save  #match creation
					#Email Setup
				    @match.send_challenge_email(@player2, @match, @player1)
				    @match.send_challenge_email(@player3, @match, @player1)
				    flash[:info] = "Your partner and opponent have been notified."
				    redirect_to root_url
				   else
					  render 'new' #In case of errors.
			    end
		    
		    elsif (@match.player2 != 'Player 2' && @match.player3 == 'Player 3' && @match.player4 != 'Player 4')

		    	@match = current_user.open_challenge_with_partner_and_opponent(@player2, @player4, @location, @game_type, @open, @time, @zip)

		    	if @match.save  #match creation
					#Email Setup
				    @match.send_challenge_email(@player2, @match, @player1)
				    @match.send_challenge_email(@player4, @match, @player1)
				    flash[:info] = "Your partner and opponent have been notified."
				    redirect_to root_url
				   else
					  render 'new' #In case of errors.
			    end
		    
		    elsif (@match.player2 == 'Player 2' && @match.player3 != 'Player 3' && @match.player4 != 'Player 4')

		    	@match = current_user.open_challenge_with_opponents(@player3, @player4, @location, @game_type, @open, @time, @zip)

		    	if @match.save  #match creation
					#Email Setup
				    @match.send_challenge_email(@player3, @match, @player1)
				    @match.send_challenge_email(@player4, @match, @player1)
				    flash[:info] = "Your opponents have been notified."
				    redirect_to root_url
				   else
					  render 'new' #In case of errors.
			    end

		    elsif (@match.player2 != 'Player 2' && @match.player3 != 'Player 3' && @match.player4 != 'Player 4')
		    
		    	@match = current_user.doubles_challenge(@player2, @player3, @player4, @location, @game_type, @open, @time, @zip)

		    	if @match.save  #match creation
					#Email Setup
				    @match.send_challenge_email(@player2, @match, @player1)
				    @match.send_challenge_email(@player3, @match, @player1)
				    @match.send_challenge_email(@player4, @match, @player1)
				    flash[:info] = "Your partner and opponents have been notified."
				    redirect_to root_url
				   else
					  render 'new' #In case of errors.
			    end
		    end
		   		
		   		
		  	
	   end
    end

def open
	#@singlesMatches = Match.where(open: 1, game_type: 'Singles', player2: 'Player 2', time: Date.today..3.years.from_now).where.not(player1: current_user.id).all.paginate(page: params[:page])
	#@doublesMatches = Match.where("open = ? AND game_type = ? OR player2 = ? OR player3 = ? OR player4 = ?", 1, 'Doubles', 'Player 2', 'Player 3', 'Player 4').where.not(player1: current_user.id, player2: current_user.id, player3: current_user.id, player4: current_user.id).where(time: Date.today..3.years.from_now).all.paginate(page: params[:page])
	if (params[:search1] && params[:search2] && params[:search3] && params[:search4])
		@creator = User.find_by(name: params[:search2])
		if (@creator == nil && params[:search2] != "")
			flash[:danger] = "That user was not found in our database."
			 redirect_to open_url
		else
			@matches = Match.search(params[:search1], params[:search2], params[:search3], params[:search4]).where("open = ? AND player2 = ? OR player3 = ? OR player4 = ?", 1, 'Player 2', 'Player 3', 'Player 4').where.not(player1: current_user.id, player2: current_user.id, player3: current_user.id, player4: current_user.id).where(time: Date.today..3.years.from_now).order(time: :asc).all.paginate(page: params[:page]).order(time: :asc)
		end
	else
		@matches = Match.where("open = ? AND player2 = ? OR player3 = ? OR player4 = ?", 1, 'Player 2', 'Player 3', 'Player 4').where.not(player1: current_user.id, player2: current_user.id, player3: current_user.id, player4: current_user.id).where(time: Date.today..3.years.from_now).all.paginate(page: params[:page]).order(time: :asc)
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

def updateWinner(winner)
	@theWinner = User.find_by(id: winner)
	@newWins = @theWinner.wins + 1.0
	@newTotal = @theWinner.total_matches_played + 1.0
	@newWinPct = (@newWins / @newTotal) * 100.0
	@theWinner.update_attributes(:wins => @newWins, :total_matches_played => @newTotal, :win_pct => @newWinPct)
end

def updateLoser(loser)
	@theLoser = User.find_by(id: loser)
	@newLosses = @theLoser.losses + 1.0
	@newTotal = @theLoser.total_matches_played + 1.0
	@newWinPct = (@theLoser.wins / @newTotal) * 100.0
	@theLoser.update_attributes(:losses => @newLosses, :total_matches_played => @newTotal, :win_pct => @newWinPct)
end

def updateInvalids(player)
	@player = User.find_by(id: player)
	@newInvalids = @player.invalids + 1
	@player.update_attributes(:invalids => @newInvalids)
end

def activatePlayers(id)
	@match = Match.find_by(id: id)
	@match.update_attributes(:p2Active => 1, :p3Active => 1, :p4Active => 1)
end

def fixPlayers1(match)
	@match = match
	@match.update_attributes(:player2 => "Player 2", :player3 => "Player 3")
end

def fixPlayers2(match)
	@match = match
	@match.update_attributes(:player2 => "Player 2", :player4 => "Player 4")
end

private

	def match_params
      params.require(:match).permit(:player1, :player2, :player3, :player4, :location,
                                   :time, :game_type, :open, :winner, :loser, :score, :zip, :p2Active, :p3Active, :p4Active, 
                                   :player2Active, :player3Active, :player4Active, :player2Accept, :player3Accept, :player4Accept,
                                   :validator1, :validator2, :validator3, :scoreValid, :validated)
    end
end
