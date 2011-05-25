Bard::Application.routes.draw do

  devise_for :users

  # root :to =>        need default page for devise

  # also Ensure you have flash messages in app/views/layouts/application.html.erb.
  #   For example:

   #    <p class="notice"><%= notice %></p>
   #    <p class="alert"><%= alert %></p

end

