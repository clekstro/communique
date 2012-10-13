Communique::Engine.routes.draw do
  match '/' => 'messages#create', :via => [:post], :as => :create_message
  match '/' => redirect('/messages/inbox')
  match '/new' => 'messages#new', :via => [:get], :as => :new_message
  match '/edit' => 'messages#edit', :via => [:get], :as => :edit_message
  match '/update' => 'messages#update', :via => [:post, :put], :as => :update_message
  match '/inbox' => 'messages#inbox', :via => [:get], :as => :inbox
  match '/drafts' => 'messages#drafts', :via => [:get], :as => :drafts
  match '/drafts' => 'messages#save_draft', :via => [:post, :put], :as => :save_draft
  match '/outbox' => 'messages#outbox', :via => [:get], :as => :outbox
  match '/trash' => 'messages#trash', :via => [:get], :as => :trash
  match '/read' => 'messages#read', :via => [:get], :as => :read_messages
  match '/unread' => 'messages#unread', :via => [:get], :as => :unread_messages
  
end
