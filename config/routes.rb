Rails.application.routes.draw do

  root "employees#index"

  resources :employees do
    collection do
      get :search
    end
  end
  resources :salary_insights, only: [:index]

  get "up" => "rails/health#show", as: :rails_health_check

end
