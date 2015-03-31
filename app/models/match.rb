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
      self.player2 = 'NOPLAYER' if self.player2 == nil
      self.player3 = 'NOPLAYER' if self.player3 == nil
      self.player4 = 'NOPLAYER' if self.player4 == nil
    end
end
