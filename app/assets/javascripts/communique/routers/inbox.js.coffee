class Communique.Routers.Inbox extends Backbone.Router
  routes: {
    'messages/inbox':'index'
  }
  index : ->
    alert "inbox reached!"