#= require templates/game_status
Estefis.Views ?= {}
class Estefis.Views.GameStatus extends Backbone.Marionette.ItemView
	className: 'game-status'
	template: 'templates/game_status'

	templateHelpers: ->
	  inProgress: @inProgress
	  won: @won

  initialize:(options) ->
  	@inProgress = options.inProgress || false
  	@won = options.won || false