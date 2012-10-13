class Communique.Collections.UnreadMessages extends Backbone.Collection
  model: Communique.Models.Message
  url: 'messages/unread'