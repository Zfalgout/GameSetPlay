class User < ActiveRecord::Base
	has_many :user_matches
	has_many :matches, through: :user_matches


	attr_accessor :remember_token, :activation_token, :reset_token

	after_initialize :defaults

    def defaults

        self.invalids ||= 0

    end

	has_many :active_relationships, class_name: "Relationship",
		foreign_key: "follower_id", dependent: :destroy

	has_many :passive_relationships, class_name:  "Relationship",
    	foreign_key: "followed_id", dependent: :destroy

	has_many :following, through: :active_relationships, source: :followed
	
	has_many :followers, through: :passive_relationships, source: :follower

	# Ensure user's email are lowercase so that they can be parsed correctly.
	before_save   :downcase_email

	# Create the activation token.
  	before_create :create_activation_digest

	# Ensure that only emails are unique.
	before_save { self.email = email.downcase }

	# Ensure that a name is present for each user.
	validates :name, presence: true, length: { maximum: 50 }

	# Valid email symbols.
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	# Ensure email validation.
	validates :email, presence: true, length: { maximum: 255 },
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: {case_sensitive: false}

	# Ensure the user has a secure password.
	has_secure_password

	# Allow for blank passwords on edit.
    validates :password, length: { minimum: 6 }, allow_blank: true

    #Password REGEX such that a valid password contains at least one letter and one number.
    validates_format_of :password, :with => /\A(?=.*[a-z])(?=.*\d).+\Z/i, message: "must contain at least one letter and one number.", allow_blank: true

	# Place other profile validations here....
	validates :zip, presence: true, length: { maximum: 5, minimum: 5 } 

	# Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

	# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

    # Remembers a user in the database for use in persistent sessions.
	def remember
	    self.remember_token = User.new_token
	    update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Forgets a user.
 	 def forget
   	 	update_attribute(:remember_digest, nil)
 	 end

     # Returns true if the given token matches the digest.
	  def authenticated?(attribute, token)
	    digest = send("#{attribute}_digest")
	    return false if digest.nil?
	    BCrypt::Password.new(digest).is_password?(token)
	  end

	# Activates an account.
	  def activate
	    update_attribute(:activated, true)
	    update_attribute(:activated_at, Time.zone.now)
	  end

	# Sends activation email.
	  def send_activation_email
	    UserMailer.account_activation(self).deliver_now
	  end

	 # Sets the password reset attributes.
	  def create_reset_digest
	    self.reset_token = User.new_token
	    update_attribute(:reset_digest, User.digest(reset_token))
	    update_attribute(:reset_sent_at, Time.zone.now)
	  end

	 # Sends password reset email.
	  def send_password_reset_email
	    UserMailer.password_reset(self).deliver_now
	  end

	 # Returns true if a password reset has expired.
	  def password_reset_expired?
	    reset_sent_at < 2.hours.ago
	  end

	 # Follows a user.
	  def follow(other_user)
	    active_relationships.create(followed_id: other_user.id)
	  end

	  # Unfollows a user.
	  def unfollow(other_user)
	    active_relationships.find_by(followed_id: other_user.id).destroy
	  end

	  # Returns true if the current user is following the other user.
	  def following?(other_user)
	    following.include?(other_user)
	  end

	  # Challenges a user to a match.
	  def challenge(other_user, location, game_type, open, time, zip)
	    matches.create(player1: self.id, user_id: self.id, player2: other_user.id, location: location, game_type: game_type, open: open, time: time, zip: zip)
	  end

	  # Creates an open challenge.
	  def open_challenge(location, game_type, open, time, zip)
	    matches.create(player1: self.id, user_id: self.id, location: location, game_type: game_type, open: open, time: time, zip: zip)
	  end

	  # Creates a private doubles challenge.
	  def doubles_challenge(partner, opponent1, opponent2, location, game_type, open, time, zip)
	    matches.create(player1: self.id, user_id: self.id, player2: partner.id, player3: opponent1.id, player4: opponent2.id, location: location, game_type: game_type, open: open, time: time, zip: zip)
	  end

	  # Creates an open challenge.
	  def open_challenge_with_partner(partner, location, game_type, open, time, zip)
	    matches.create(player1: self.id, user_id: self.id, player2: partner.id, location: location, game_type: game_type, open: open, time: time, zip: zip)
	  end

	  # Creates an open challenge.
	  def open_challenge_one_opponent(opponent, location, game_type, open, time, zip)
	    matches.create(player1: self.id, user_id: self.id, player3: opponent.id, location: location, game_type: game_type, open: open, time: time, zip: zip)
	  end

	  # Creates an open challenge.
	  def open_challenge_with_partner_and_opponent(partner, opponent, location, game_type, open, time, zip)
	    matches.create(player1: self.id, user_id: self.id, player2: partner.id, player3: opponent.id, location: location, game_type: game_type, open: open, time: time, zip: zip)
	  end

	  # Creates an open challenge.
	  def open_challenge_with_opponents(opponent1, opponent2, location, game_type, open, time, zip)
	    matches.create(player1: self.id, user_id: self.id, player3: opponent1.id, player4: opponent2.id, location: location, game_type: game_type, open: open, time: time, zip: zip)
	  end

	  # Returns a user's status feed.
	  def feed
	    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
	    Match.where("user_id IN (#{following_ids})
	                     OR user_id = :user_id", user_id: id)
	  end

	  def self.search(query)
	      #Have to catch in case of nil.
	      #where("name like ?", User.find_by(name: "%#{query}%").name)
	      where("name LIKE ?", "%#{query}%")
		end

    #Private methods to work in account activation.
    private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
