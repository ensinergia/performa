require 'subdomain' 
GestionDesempeno::Application.routes.draw do
  
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  
  # TODO: fix this --> http://ievolutioned.lvh.me:3000/users/sign_up to a redirect to http://lvh.me:3000/users/sign_up for new_user_session_url
  match '/panorama' => 'panoramas#index'
  
  constraints(Subdomain) do
    resources :accounts, :only => [:index]
    match '/accounts/user_info' => 'accounts#user_info', :as => 'user_info', :via => :get
    match '/accounts/info' => 'accounts#account_info', :as => 'account_info', :via => :get
    match '/accounts/user_tasks' => 'accounts#user_tasks', :as => 'user_tasks', :via => :get
  end  
  
  match '/accounts/(:action)', :to => redirect('/users/sign_in'), :via => :get
  
  root :to => "home#index"

end
