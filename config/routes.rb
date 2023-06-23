Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :students
  resources :teachers do
    collection do
      post "follow", to: "teachers#follow" # /teachers/:id/follow
      post "unfollow", to: "teachers#unfollow" # /teachers/:id/unfollow
    end
  end
end
