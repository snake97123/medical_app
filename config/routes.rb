Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"
  resources :questions, only: [:new, :create, :show, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
    resources :answers, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :informations, only: :index

end
