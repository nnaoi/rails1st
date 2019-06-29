Rails.application.routes.draw do
  post "logout" => "users#logout"
  get "signin" => "users#signin_form"
  post "signin" => "users#signin"
  
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  
  get "/" => "home#top"
  get "about" => "home#about"
  
  get "schedules/top" => "schedules#top"
  get "schedules/new" => "schedules#new"
  post "schedules/create" => "schedules#create"
  post "schedules/date_update" => "schedules#date_update"
  get "schedules/:id" => "schedules#show"
  get "schedules/:id/edit" => "schedules#edit"
  post "schedules/:id/update" => "schedules#update"
  post "schedules/:id/destroy" => "schedules#destroy"
  
  get "users/index" => "users#index"
  get "users/new" => "users#new"
  post "users/create" => "users#create"
  
end
