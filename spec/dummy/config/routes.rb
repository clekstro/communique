Rails.application.routes.draw do
  devise_for :users
  mount Communique::Engine => "/messages"
end
