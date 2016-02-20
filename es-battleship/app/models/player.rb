class Player < ActiveRecord::Base
	attr_accessible :token, :active
	belongs_to :game

	before_create :create_unique_token

	def create_unique_token
	  # token is 4 upper-case letters and number (no 0's, 1's, O's, I's)
	  valid_chars = ['a'..'h', 'j'..'n', 'p'..'z','2'..'9'].map{|r|r.to_a}.flatten
	  token_size  = 4

	  self.token = loop do
	    #loop until a unique token is found
	    random_token =  Array.new(token_size).map{valid_chars[rand(valid_chars.size)]}.join()
	    break random_token if Player.find_by(token: random_token).nil?
	  end
	end

	def won

	end

end