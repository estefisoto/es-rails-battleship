#= require templates/board
Estefis.Views ?= {}
class Estefis.Views.Board extends Backbone.Marionette.ItemView
	template: 'templates/board'
	className: 'board'
	tagName: 'table'

	templateHelpers: ->
	    rowCount: @rowCount
	    colCount: @colCount

	initialize:(options) ->
		@rowCount = options.row_count
		@colCount = options.col_count