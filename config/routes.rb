Communique::Engine.routes.draw do
  # custom routes first
  #match 'messages/trash' => 'messages#trash', :as => :trash
  #match 'messages/unread' => 'messages#unread', :as => :unread
  #match 'messages/drafts' => 'messages#drafts', :as => :drafts
  #match 'messages/drafts/:id/delete' => 'messages#destroy_draft', :as => :destroy_draft
  #match 'messages/drafts/:id/trash' => 'messages#trash_draft_message', :as => :trash_draft
  #match 'messages/sent' => 'messages#sent', :as => :sent
  #match 'messages/sent/:id' => 'messages#show_sent', :as => :show_sent
  #match 'messages/sent/:id/delete' => 'messages#destroy_sent', :as => :destroy_sent
  #match 'messages/sent/:id/trash' => 'messages#trash_sent_message', :as => :trash_sent
  #match 'messages/:id/reply' => 'messages#reply', :as => :reply
  #match 'messages/:id/delete' => 'messages#destroy', :as => :destroy
  #match 'messages/:id/trash' => 'messages#trash_message', :as => :trash
  #match 'messages/bulk/delete' => 'messages#bulk_destroy', :as => :bulk_destroy, :via => [:post]
  #match 'messages/bulk/trash' => 'messages#bulk_trash', :as => :bulk_trash, :via => [:post]

  delete_paths = Proc.new do
    member do
      post 'trash'
      post 'delete'
      post 'restore'
    end
    collection do
      post 'bulk_trash'
      post 'bulk_delete'
    end
  end
 
  match '/messages' => redirect('/messages/inbox')

  namespace :messages do
    resources :inbox, :only => [:index, :show] do
      get 'reply', on: :member
      delete_paths.call
    end
    resources :trash, :only => [:index, :show]
    resources :sent, :except => [:new, :create, :edit, :update] do
      delete_paths.call
    end
    resources :drafts, :except => [:show] do
      post 'send_draft', on: :member
      delete_paths.call
    end
  end 
end
