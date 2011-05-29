Bard::Application.routes.draw do

  root :to => 'projects#index'

  devise_for :users

  namespace "admin" do
    resources :users

    resources :projects do
      post 'add_member'
      put 'update_member'
      delete 'remove_member'
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

  resources :stories do
    post 'add_rating'
    resources :comments
    resources :tags
  end

  resources :comments
  resources :tags






  # also Ensure you have flash messages in app/views/layouts/application.html.erb.
  #   For example:

   #    <p class="notice"><%= notice %></p>
   #    <p class="alert"><%= alert %></p

end

