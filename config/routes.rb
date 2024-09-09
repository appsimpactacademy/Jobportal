Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root 'home#index'
  resources :jobs, only: [:index, :show]
  resources :companies, only: [:index, :show]
  resources :applied_jobs
  resources :user_saved_jobs

  namespace :company do 
    resources :jobs
    resources :applied_jobs
  end
end
