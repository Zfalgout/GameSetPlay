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

      if player2.nil?
	      self.player2 = 'NOPLAYER' 
	  end
      
      if player3.nil?
	      self.player3 = 'NOPLAYER'
	  end
	    
	  if player4.nil?
	      self.player4 = 'NOPLAYER'
	  end

    end
end
