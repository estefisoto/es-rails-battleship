class Service::PlayActionController < ApplicationController
	respond_to :json
	include GameHelper

	def hit
		x = params[:x]
		y = params[:y]
		player = get_player_from_token(params[:token])
		opponent_ocean = get_opponents_ocean(player: player)
		isHit = opponent_ocean.check_for_hit(x.to_i, y.to_i)
		render json: { x: x, y: y, isHit: isHit}
	end
end