Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'users/:id/posts' => 'users#posts', :as => :user_posts

  resources :posts, only: %i[create show update destroy] do
    resources :comments
  end

  resources :comments do
    resources :reactions, only: %i[create destroy]
  end
end
