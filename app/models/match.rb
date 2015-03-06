class Match < ActiveRecord::Base
	validates :user_id, presence: true
	validates :player1, presence: true
	validates :location, presence: true
	validates :time, presence: true
	validates :type, presence: true
	validates :public, presence: true

	#Put in descending order.
	default_scope -> { order(created_at: :desc) }
end
