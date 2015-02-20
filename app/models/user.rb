class User < ActiveRecord::Base
	#Ensure that only emails are unique.
	before_save { self.email = email.downcase }

	#Ensure that a name is present for each user.
	validates :name, presence: true, length: { maximum: 50 }

	#Valid email symbols.
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	#Ensure email validation.
	validates :email, presence: true, length: { maximum: 255 },
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: {case_sensitive: false}

	#Ensure the user has a secure password.
	has_secure_password

	#Ensure the password is of a minimum length
	validates :password, length: { minimum: 6 }

	#Ensure that the zip is valid.

	#Ensure that 

end
