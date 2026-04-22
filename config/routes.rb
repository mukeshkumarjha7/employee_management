Rails.application.routes.draw do

  resources :employees do
    collection do
      get :search
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
