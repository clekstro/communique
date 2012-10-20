Communique::Engine.routes.draw do
  # custom routes first
  match 'messages/trash' => 'messages#trash', :as => :trash
  match 'messages/unread' => 'messages#unread', :as => :unread
  match 'messages/drafts' => 'messages#drafts', :as => :drafts
  match 'messages/sent' => 'messages#sent', :as => :sent
  match 'messages/sent/:id' => 'messages#show_sent', :as => :show_sent

  resources :messages
end
