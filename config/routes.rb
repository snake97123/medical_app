Rails.application.routes.draw do
  devise_for :users
  get 'questions/index'
  root to: "questions#index"
end
