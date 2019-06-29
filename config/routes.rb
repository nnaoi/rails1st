Rails.application.routes.draw do
  get "settings/group" => "settings#group"
  post "settings/group/new" => "settings#group_new"
  post "settings/group/add_user" => "settings#add_self_to_group"
  post "settings/group/remove_user" => "settings#remove_self_group"
  
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
