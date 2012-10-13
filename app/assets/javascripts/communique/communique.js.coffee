window.Communique =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Communique.Routers.Inbox
    Backbone.history.start({
      pushState: true
      root: "/messages/inbox/"
    })

$(document).ready ->
  Communique.init()
