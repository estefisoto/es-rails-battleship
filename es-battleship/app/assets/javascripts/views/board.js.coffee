#= require templates/board
Estefis.Views ?= {}
class Estefis.Views.Board extends Backbone.Marionette.ItemView
	template: 'templates/board'
	className: 'board'
	tagName: 'table'

	events:
    "click .js-ready": 'hitClick'

	templateHelpers: ->
	    rowCount: @rowCount
	    colCount: @colCount

	initialize:(options) ->
		@rowCount = options.row_count
		@colCount = options.col_count
		@shipLocations = options.locations

	onShow: ->
		@displayShipLocations() if @shipLocations?

	hitClick: (evt) ->
		$evtTarget= $(evt.target)
		x = $evtTarget.data('x')
		y = $evtTarget.data('y')
		window.alert('x:'+x+'; y:' + y)

	displayShipLocations: ->
		for location in @shipLocations
			$locationCell = $("td[data-x='"+location.x+"'][data-y='"+location.y+"']")
			shipClass = location.ship_kind.toLowerCase().replace(" ", "-")
			$locationCell.removeClass( "empty js-open" ).addClass(shipClass)
