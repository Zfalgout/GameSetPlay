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
	default_scope -> { order(created_at: :desc) }

	after_initialize :defaults

    def defaults

	      self.player2 ||= 'Player 2' 

	      self.player3 ||= 'Player 3'

	      self.player4 ||= 'Player 4'


    end

    def self.search(query1, query2)
    	@query1 = query1
    	@query2 = query2

      #Have to catch in case of nil.
  		if (query1 != "" && query2 != "")
  			where("game_type like ? AND player1 like ?", "%#{query1}%", User.find_by(name: "#{query2}").id)
  			#where("game_type like ?", "%#{query1}%")
  		elsif (query1 != "")
  			where("game_type like ?", "%#{query1}%")
  		elsif (query2 != "")
  			where("player1 like ?", User.find_by(name: "#{query2}").id)
  		else
      		where("open = ?", 1)
      	end
	  #where("game_type like ?", "%#{query}%") 
	end

	#def self.search1(query1)
		#where("game_type like ?", "%#{query1}%")
	#end

end
