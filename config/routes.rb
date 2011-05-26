Bard::Application.routes.draw do

  namespace "admin" do
    resources :users, :users, :projects
  end

  #resources :releases

  #resources :tags
  #resources :members
  #resources :projects

  devise_for :users

  root :to => 'projects#index'

  # also Ensure you have flash messages in app/views/layouts/application.html.erb.
  #   For example:

   #    <p class="notice"><%= notice %></p>
   #    <p class="alert"><%= alert %></p

end

