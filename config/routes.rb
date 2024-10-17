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
  resources :user_saved_jobs do 
    collection do 
      get :my_saved_jobs
    end
  end

  get 'settings' => "notification_settings#manage_notification_settings"
  resources :notification_settings, only: %i[create update]

  namespace :company do 
    resources :jobs do
      member do
        post :export_job_applications
      end
    end
    resources :applied_jobs
  end
end
