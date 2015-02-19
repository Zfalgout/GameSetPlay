Class User
	attr_accessor :name, :email, :birthday, :user_rating, :NTRP_rating, :wins, :losses, :win_pct, :total_matches_played,
		:tournament_matches_won, :tournament_matches_lost, :tournaments_won, :challenge_matches_won, :challenege_matches_lost,
		:challenges_posted, :challenges_accepted, :city, :state, :zip, :num_friends, :years_played, :about, :gender,
		:preference_of_play, :age

	def intialize(attributes = {})
		@name = attributes[:name]
		@email = attributes[:email]
		@birthday = attributes[:birthday]
		@user_rating = attributes[:user_rating] 
		@NTRP_rating = attributes[:NTRP_rating]
		@wins = attributes[:wins] 
		@losses = attributes[:losses] 
		@win_pct = attributes[:win_pct] 
		@total_matches_played = attributes[:total_matches_played] 
		@tournament_matches_won = attributes[:tournament_matches_won]
		@tournament_matches_lost = attributes[:tournament_matches_lost] 
		@tournaments_won = attributes[:tournaments_won] 
		@challenge_matches_won = attributes[:challenge_matches_won] 
		@challenege_matches_lost = attributes[:challenege_matches_lost]
		@challenges_posted = attributes[:challenges_posted]
		@challenges_accepted = attributes[:challenges_accepted] 
		@city = attributes[:city] 
		@state = attributes[:state]
		@zip = attributes[:zip] 
		@num_friends = attributes[:num_friends]
		@years_played = attributes[:years_played]
		@about = attributes[:about]
		@gender = attributes[:gender]
		@preference_of_play = attributes[:preference_of_play]
		@age = attributes[:age]
	end

	def formatted_email
		"#{@name} <#{@email}>"
	end
