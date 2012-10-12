Rails.application.routes.draw do
  devise_for :users

  root :to => redirect('/messages/inbox')
  mount Communique::Engine => "/"
end
