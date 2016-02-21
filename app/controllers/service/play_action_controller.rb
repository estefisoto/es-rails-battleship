class Service::PlayActionController < ApplicationController
	respond_to :json
	include GameHelper

	def hit
		x = params[:x]
		y = params[:y]
		player = get_player_from_token(params[:token])
		opponent = get_opponent_player(player: player)
		opponent_ocean = Ocean.find_by(player_id: opponent.id)
		isHit = opponent_ocean.check_for_hit(x.to_i, y.to_i)
		action_results = {
			isHit: isHit,
			x: x,
			y: y
 		}
		if isHit && opponent_ocean.check_for_sunk(x.to_i, y.to_i)
			action_results[:gameOver] = opponent_ocean.check_for_all_sunk
		end
		game = player.game
		game.turn = opponent.id
		game.save
		# Publish results to opponent channel
		PublishPlayAction.new(player: opponent, message: action_results ).call
		render json: action_results
	end

end