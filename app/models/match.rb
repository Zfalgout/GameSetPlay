class Match < ActiveRecord::Base
	has_many :user_matches
	has_many :users, through: :user_matches
	
	validates :player1, presence: true
	validates :location, presence: true
	validates :time, presence: true
	validates :game_type, presence: true
	validates :open, presence: true
	validates :zip, presence: true

	#Put in descending order.

#default_scope -> { order(:time) }

	after_initialize :defaults

    def defaults

	      self.player2 ||= 'Player 2' 

	      self.player3 ||= 'Player 3'

	      self.player4 ||= 'Player 4'


    end

    def self.search(query1, query2, query3, query4)
    	@query2 = query2
    	@creator = User.find_by(name: "#{@query2}")

      #Have to catch in case of nil.
  		if (query1 != "" && query2 != "" && query3 != "" && query4 != "") #A user uses all search criteria.
  				where("game_type like ? AND player1 like ? AND zip like ? AND time like ?", "%#{query1}%", User.find_by(name: "#{query2}").id, "%#{query3}%", "%#{query4}%")

  		elsif (query1 != "" && query2 == "" && query3 == "" && query4 == "") #A user searches for a match by type.
  			where("game_type like ?", "%#{query1}%")
  		
  		elsif (query1 == "" && query2 != "" && query3 == "" && query4 == "") #A user searches for a match by creator
  			where("player1 like ?", User.find_by(name: "#{query2}").id)
  		
  		elsif (query1 == "" && query2 == "" && query3 != "" && query4 == "") #A user searches for a match by zip.
  			where("zip like ?", "%#{query3}%")
  		
  		elsif (query1 == "" && query2 == "" && query3 == "" && query4 != "") #A user searches for a match by date.
  			where("time like ?", "%#{query4}%")

  		elsif (query1 != "" && query2 != "" && query3 == "" && query4 == "") #A user searches for a match by type and creator.
  			where("game_type like ? AND player1 like ?", "%#{query1}%", User.find_by(name: "#{query2}").id)
  		
  		elsif (query1 != "" && query2 == "" && query3 != "" && query4 == "") #A user searches for a match by type and zip.
  			where("game_type like ? AND zip like ?", "%#{query1}%", "%#{query3}%")

  		elsif (query1 == "" && query2 != "" && query3 != "" && query4 == "") #A user searches for a match by creator and zip.
  			where("player1 like ? AND zip like ?", User.find_by(name: "#{query2}").id, "%#{query3}%")

  		elsif (query1 != "" && query2 == "" && query3 == "" && query4 != "") #A user searches for a match by type and date.
  			where("game_type like ? AND zip like ?", "%#{query1}%", "%#{query3}%")
  		
  		elsif (query1 == "" && query2 != "" && query3 == "" && query4 != "") #A user searches for a match by creator and date.
  			where("player1 like ? AND time like ?", User.find_by(name: "#{query2}").id, "%#{query4}%")
  		
  		elsif (query1 == "" && query2 == "" && query3 != "" && query4 != "") #A user searches for a match by zip and date.
  			where("zip like ? AND time like ?", "%#{query3}%", "%#{query4}%")

  		elsif (query1 != "" && query2 != "" && query3 != "" && query4 == "") #A user searches for a match by type, creator and zip. 
  			where("game_type like ? AND player1 like ? AND zip like ?", "%#{query1}%", User.find_by(name: "#{query2}").id, "%#{query3}%")

  		elsif (query1 != "" && query2 == "" && query3 != "" && query4 != "") #A user searches for a match by type, zip and date.
  			where("game_type like ? AND zip like ? AND time like ?", "%#{query1}%", "%#{query3}%", "%#{query4}%")

  		elsif (query1 != "" && query2 != "" && query3 == "" && query4 != "") #A user searches for a match by type, creator and date.
  			where("game_type like ? AND player1 like ? AND time like ?", "%#{query1}%", User.find_by(name: "#{query2}").id, "%#{query4}%")
  		
  		elsif (query1 == "" && query2 != "" && query3 != "" && query4 != "") #A user searches for a match by creator, zip and date.
  			where("player1 like ? AND zip like ? AND time like ?", User.find_by(name: "#{query2}").id, "%#{query3}%", "%#{query4}%")

  		else
      		where("open = ?", 1)
      	end

	end

	#def self.search1(query1)
		#where("game_type like ?", "%#{query1}%")
	#end

end
