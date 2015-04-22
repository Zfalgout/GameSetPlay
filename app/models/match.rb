class Match < ActiveRecord::Base
	has_many :user_matches
	has_many :users, through: :user_matches
	
	validates :player1, presence: true
	validates :location, presence: true
	validates :time, presence: true
	validates :game_type, presence: true
	validates :open, presence: true

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
  		if (@query1 != 0 && @query2 != 0)
  			where("game_type like ? AND player1 like ?", "%#{query1}%", User.find_by(name: "#{query2}").id)
  		elsif (@query1 != 0)
  			where("game_type like ?", "%#{query1}%")
  		elsif (@query2 != 0)
  			where("player1 like ?", User.find_by(name: "#{query2}").id)
  		#else
      		#where("game_type like ? AND player1 like ?", "%#{query1}%", User.find_by(name: "#{query2}").id)
      	end
	  #where("game_type like ?", "%#{query}%") 
	end
end
