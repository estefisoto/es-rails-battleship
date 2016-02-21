#= require templates/board
Estefis.Views ?= {}
class Estefis.Views.Board extends Backbone.Marionette.ItemView
	template: 'templates/board'
	tagName: 'table'

	events:
    "click .js-ready": 'hitClick'

	templateHelpers: ->
	  rowCount: @rowCount
	  colCount: @colCount
	  opponent: @opponent

	initialize:(options) ->
		@rowCount = options.row_count
		@colCount = options.col_count
		@oceanLocations = options.locations
		@token = options.player_token || false
		@opponent = options.opponent || false
		unless @opponent
			@on "opponent:action", (data) =>
				$cellAffected = @$el.find(" td[data-x='"+data.x+"'][data-y='"+data.y+"']")
				@addCellState($cellAffected, data.isHit)

		return

	onShow: ->
		@displayLocations() if @oceanLocations?
		return

	hitClick: (evt) ->
		$cellClicked = $(evt.target)
		x = $cellClicked.data('x')
		y = $cellClicked.data('y')
		url = '/service/play/hit/'+@token+'/'+x+'/'+y
		$.get( url, (data) => 
			# Do not allow user to click on same cell
			$cellClicked.removeClass( "empty js-ready" )
			@addCellState($cellClicked, data.isHit)
		)
		return

	displayLocations: ->
		for location in @oceanLocations
			$locationCell = $("td[data-x='"+location.x+"'][data-y='"+location.y+"']")
			if location.ship_kind.length > 0
				shipClass = location.ship_kind.toLowerCase().replace(" ", "-")
				$locationCell.removeClass( "empty" ).addClass(shipClass)
				if(location.isHit)
					$locationCell.append("<div class='hit'>H</div>")
			else
				@addCellState($locationCell, location.isHit)
		return

	addCellState: ($cell, isHit) ->
		if isHit
			$cell.append("<div class='hit'>H</div>")
		else
			$cell.append("<div class='miss'>M</div>")
		return