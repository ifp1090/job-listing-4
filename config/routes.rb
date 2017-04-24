Rails.application.routes.draw do
  devise_for :users
  resources :jobs do
    collection do
      get :search
    end
    resources :resumes
  end
  
  namespace :account do
    resources :jobs
  end

  namespace :admin do
    namespace :account do
      resources :jobs do
        member do
          post :publish
          post :hide
        end

        resources :resumes
      end
    end
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
    resources :categories
  end
  root 'welcome#index'
end
