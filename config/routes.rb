Rails.application.routes.draw do
  get 'groups/members' => "groups#members"
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
  post "schedules/top" => "schedules#top"
  get "schedules/new" => "schedules#new"
  post "schedules/create" => "schedules#create"
  get "schedules/:id" => "schedules#show"
  get "schedules/:id/edit" => "schedules#edit"
  # validation_error ---> バリデーションエラーが起きた際、getリクエストに対応するた
  get "schedules/:id/update" => "schedules#update_error"
  post "schedules/:id/update" => "schedules#update"
  post "schedules/:id/destroy" => "schedules#destroy"
  
  get "users/index" => "users#index"
  get "signup" => "users#new"
  get "users/create" => "users#create_refresh"
  post "users/create" => "users#create"
end
