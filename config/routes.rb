Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :students
  resources :teachers do
    collection do # RICKNOTE collection v.s. member
      post "follow", to: "teachers#follow" # /teachers/follow
      post "unfollow", to: "teachers#unfollow" # /teachers/unfollow
    end
  end
end
