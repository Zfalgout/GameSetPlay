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
end
