Shadowmsg::Application.routes.draw do
  devise_for :users, :controllers => {omniauth_callbacks: 'omniauth_callbacks'}
  root to: "welcome#index"
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  resources :messages
  get 'new_message'=> 'messages#new'
  get 'msg_read' => 'messages#msg_read'
  get 'privacy' => 'privacy#show'
  get 'login_success' => 'messages#login_success'
end
