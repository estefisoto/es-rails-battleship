# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require application-setup
#= require views/layout

Estefis.BattleShipGame = new Backbone.Marionette.Application()

Estefis.BattleShipGame.addRegions
  main: "main"

Estefis.BattleShipGame.addInitializer (options) ->
	layout = new Estefis.Views.Layout options
	@main.show layout