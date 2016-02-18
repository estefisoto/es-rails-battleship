#Setup Marionette to use JST for its template rendering
#= require prelude-min
#= require underscore
#= require backbone
#= require backbone.marionette
Backbone.Marionette.Renderer.render = (template, data) ->
  if JST[template]
    JST[template](data)
  else
    gs.console.error("Template not found!")