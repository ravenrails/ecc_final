Bard::Application.routes.draw do

  root :to => 'home#my_account'

  devise_for :users

  resource :home, :controller => 'home', :only => [ :index ]  do
      member do
        get "index"
        get "my_account"
        get "change_password"
        put "update_account"
      end
  end

  resources :projects do
    resources :releases
  end

  resources :releases do
    resources :stories do
      put 'update_status'
    end
  end

  resources :backlogs
  
  resources :stories do
    post 'add_rating'
    resources :comments
    resources :tags
  end


  ########################################################
  ## Admin
  devise_for :admins
  #, :path_names => { :sign_in => 'login', :sign_out => 'logout'}

  devise_scope :admin do
    match 'admin/login'  => 'devise/sessions#new'
    match 'admin/logout' => 'devise/sessions#destroy'
  end


  namespace "admin" do
    match "/my_account"      => 'home#my_account'
    match "/change_password" => 'home#change_password'
    match "/update_account"  => 'home#update_account', :via => :put

    root :to => 'users#index'
    resources :users, :project_members
    resources :projects do
      post   'add_member'
      put    'update_member'
      delete 'remove_member'
    end
  end

end

