Bard::Application.routes.draw do

  root :to => 'projects#index'

  resources :stories

  namespace "admin" do
    resources :users

    resources :projects do
      post 'add_member'
    end
  end

  resources :releases
  #resources :tags
  #resources :members
  #resources :projects

  devise_for :users



  # also Ensure you have flash messages in app/views/layouts/application.html.erb.
  #   For example:

   #    <p class="notice"><%= notice %></p>
   #    <p class="alert"><%= alert %></p

end

