Bard::Application.routes.draw do

  devise_for :admins#,    :path_names => { :sign_in => 'login', :sign_out => 'logout'}

  devise_scope :admin do
    match 'admin/login' => 'devise/sessions#new'
    match 'admin/logout' => 'devise/sessions#destroy'
  end

  root :to => 'projects#index'

  devise_for :users

  namespace "admin" do
    resources :users
    resources :project_members
    resources :projects do
      post 'add_member'
      put 'update_member'
      put 'remove_member'
    end
    root :to => 'users#index'
  end

  resources :projects do
    resources :releases
  end

  resources :releases do
    resources :stories do
      put 'update_status'
    end
  end

  resources :stories do
    post 'add_rating'
    resources :comments
    resources :tags
  end

end

