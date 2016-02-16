class Ocean < ActiveRecord::Base
	has_many :locations, dependent: :destroy
	belongs_to :game
	belongs_to :player
	has_many :ships, dependent: :destroy

	X_MAX = Rails.application.config.row_num
	Y_MAX = Rails.application.config.col_num

	def location_valid(x,y)
		if(x >= 1 && x <= X_MAX && y>=1 && y <= Y_MAX)
			self.locations.where(x:x,y:y).empty?
		else
			false
		end
	end

end