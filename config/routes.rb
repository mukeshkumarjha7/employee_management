Rails.application.routes.draw do
  get "salary_insights/index"

  resources :employees do
    collection do
      get :search
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
