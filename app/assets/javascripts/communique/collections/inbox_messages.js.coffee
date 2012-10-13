class Communique.Collections.InboxMessages extends Backbone.Collection
  model: Communique.Models.Message
  url: 'messages/inbox'