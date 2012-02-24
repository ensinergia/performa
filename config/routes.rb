require 'subdomain' 
GestionDesempeno::Application.routes.draw do
  
  constraints(NoSubdomain) do
    devise_for :users, :controllers => { :registrations => "users/registrations" }, :only => :registrations 
  end
  
  devise_for :users, :skip => :registrations
  

  
  constraints(Subdomain) do
    resources :accounts, :only => [:index, :update]
    match '/accounts/user_info' => 'accounts#user_info', :as => 'user_info', :via => :get
    match '/accounts/account_info' => 'accounts#account_info', :as => 'account_info', :via => :get
    match '/accounts/user_tasks' => 'accounts#user_tasks', :as => 'user_tasks', :via => :get
    match '/accounts/destroy_current' => 'accounts#destroy', :as => 'destroy_account', :via => :delete
    
    match '/panorama' => 'panoramas#index'
    match '/operative_objectives/order' => 'operative_objectives#order' , :as=>"order_operative_objectives"
    
    
    
    match '/panorama/area/(:area)' => 'panoramas#index' , :as=>"area_panorama"
    match '/operative_objectives/area/(:area)' => 'operative_objectives#index' , :as=>"area_operative_objectives"
    match '/operative_objectives/export/' => 'operative_objectives#export' , :as=>"export_operative_objectives"
    match '/operating_cycles/area/(:area)' => 'operating_cycles#index' , :as=>"area_operating_cycles"
    match '/projects/area/(:area)' => 'projects#index' , :as=>"area_projects"
    match '/comments/for/(:model)/(:id)' => 'comments#show' , :as=>"show_comments"
    resources :comments, :only => [:create, :destroy]
    resources :strategic_lines, :only => [:index, :destroy, :edit, :update, :create, :new]
    resources :strategic_objectives, :except => :show
    resources :operating_cycles
    resources :operative_objectives
    resources :pointers
    resources :projects

    match '/people/bulk_update_admin' => 'people#bulk_update_admin', :as => 'bulk_update_admin', :via => :put
    
    resources :people, :only => [:index, :new, :edit,:create,:update,:destroy]
    
    match '/areas/admin' => 'areas#admin', :as => 'areas_admin', :via => :get
    match '/areas/select' => 'areas#select', :as => 'area_select', :via => :get
    resources :areas, :only => [:index, :new, :create, :edit, :update]
    
    resources :operating_objetives, :only => [:index, :new, :create, :edit, :update]
    
    match 'contextual_legends/show' => 'contextual_legends#show', :via => :post
    
    namespace(:admin) do
      resources :contextual_legends, :only => [:index, :create, :new, :edit, :update]
    end
    
    namespace(:creed) do
      resources :visions, :only => [:index, :new, :create, :show, :edit, :update]  
      resources :missions, :only => [:index, :new, :create, :show, :edit, :update] 
      resources :war_cries, :only => [:index, :new, :create, :show, :edit, :update] 
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
  
  match '/home/confirm' => 'home#confirm', :as => 'confirm', :via=>:get
  match '/panorama', :to => redirect('/users/sign_in'), :via => :get
  match '/accounts/(:action)', :to => redirect('/users/sign_in'), :via => :get
  
  root :to => "home#index"

end
