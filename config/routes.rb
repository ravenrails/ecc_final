Bard::Application.routes.draw do

<<<<<<< HEAD



  get "tags/index"

  get "tags/show"

  get "tags/edit"

  get "tags/new"

=======
>>>>>>> 522e5c8a874383f566ad5e75d938574bd15af100
  resources :members 
  resources :projects 

  devise_for :users

  root :to => 'projects#index'     

  # also Ensure you have flash messages in app/views/layouts/application.html.erb.
  #   For example:

   #    <p class="notice"><%= notice %></p>
   #    <p class="alert"><%= alert %></p

end

