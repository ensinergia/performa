require 'subdomain' 
GestionDesempeno::Application.routes.draw do
  
  constraints(NoSubdomain) do
    devise_for :users, :controllers => { :registrations => "users/registrations" }, :only => :registrations 
  end
  
  devise_for :users, :skip => :registrations
  
  constraints(Subdomain) do
    resources :accounts, :only => [:index]
    match '/accounts/user_info' => 'accounts#user_info', :as => 'user_info', :via => :get
    match '/accounts/info' => 'accounts#account_info', :as => 'account_info', :via => :get
    match '/accounts/user_tasks' => 'accounts#user_tasks', :as => 'user_tasks', :via => :get
    match '/panorama' => 'panoramas#index'
    
    resources :comments, :only => [:create, :destroy]
    
    namespace(:creed) do
      resources :visions, :only => [:index, :new, :create, :show, :edit, :update]  
      resources :missions, :only => [:index, :new, :create, :show, :edit, :update]    
    end
    
    namespace(:swot) do
      resources :analyses, :only => [:index, :new, :create, :destroy, :update] do
        
        resources :comments, :only => [:index]
        
        collection do
          match '/external' => 'analyses#externals', :as => 'external', :via => :get
          match '/internal' => 'analyses#internals', :as => 'internal', :via => :get
        end
      end
    end
    
  end  
  
  match '/panorama', :to => redirect('/users/sign_in'), :via => :get
  match '/accounts/(:action)', :to => redirect('/users/sign_in'), :via => :get
  
  root :to => "home#index"

end
