Backbone.Marionette.Renderer.render = (template, data) ->
    path = JST[template]
    unless path
        throw "Template #{template} not found"
    path(data)