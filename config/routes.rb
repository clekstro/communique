Communique::Engine.routes.draw do
  match '/messages' => 'messages#create', :via => [:post], :as => :create_message
  match '/messages/new' => 'messages#new', :via => [:get], :as => :new_message
  match '/messages/edit' => 'messages#edit', :via => [:get], :as => :edit_message
  match '/messages/update' => 'messages#update', :via => [:post, :put], :as => :update_message
  match '/messages/inbox' => 'messages#inbox', :via => [:get], :as => :inbox
  match '/messages/drafts' => 'messages#drafts', :via => [:get], :as => :drafts
  match '/messages/drafts' => 'messages#save_draft', :via => [:post, :put], :as => :save_draft
  match '/messages/outbox' => 'messages#outbox', :via => [:get], :as => :outbox
  match '/messages/trash' => 'messages#trash', :via => [:get], :as => :trash
  match '/messages/read' => 'messages#read', :via => [:get], :as => :read_messages
  match '/messages/unread' => 'messages#unread', :via => [:get], :as => :unread_messages
  match '/messages' => redirect('/messages/inbox')
end
