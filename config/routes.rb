Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/swagger'
  mount Rswag::Api::Engine => '/swagger'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :stocks, only: %i[index create update destroy]
    end
  end
end
