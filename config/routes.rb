Bard::Application.routes.draw do




  get "tags/index"

  get "tags/show"

  get "tags/edit"

  get "tags/new"

  resources :members 

  devise_for :users

  root :to => 'project#index'     

  # also Ensure you have flash messages in app/views/layouts/application.html.erb.
  #   For example:

   #    <p class="notice"><%= notice %></p>
   #    <p class="alert"><%= alert %></p

end

