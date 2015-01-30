class User < ActiveRecord::Base
	include RatingAverage
	has_secure_password
	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, length: { minimum: 4 }
	validate :password, :has_uppercase_and_digit
	has_many :ratings, dependent: :destroy
	has_many :memberships

	def has_uppercase_and_digit
		unless password.match(/[(=?[A-Z])(=?\d)]/)
			errors.add(:password, "needs to include at least one uppercase letter and one digit")
		end
	end
end
