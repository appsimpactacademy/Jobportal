Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :jobs, only: [:index, :show]
  resources :companies, only: [:index, :show]
  resources :applied_jobs

  namespace :company do 
    resources :jobs
    resources :applied_jobs
  end
end
