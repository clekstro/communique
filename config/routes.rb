Communique::Engine.routes.draw do
  # custom routes first
  match 'messages/trash' => 'messages#trash', :as => :trash
  match 'messages/unread' => 'messages#unread', :as => :unread
  match 'messages/drafts' => 'messages#drafts', :as => :drafts
  match 'messages/drafts/:id/delete' => 'messages#destroy_draft', :as => :destroy_draft
  match 'messages/sent' => 'messages#sent', :as => :sent
  match 'messages/sent/:id' => 'messages#show_sent', :as => :show_sent
  match 'messages/sent/:id/delete' => 'messages#destroy_sent', :as => :destroy_sent
  match 'messages/:id/reply' => 'messages#reply', :as => :reply
  match 'messages/:id/delete' => 'messages#destroy', :as => :destroy
  match 'messages/bulk/delete' => 'messages#destroy_in_bulk', :as => :bulk_destroy
  
  resources :messages
end
