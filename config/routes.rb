Rails.application.routes.draw do
  resources :urls, only: [:create, :show] do
    member do  
      get :stats
    end
  end 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
