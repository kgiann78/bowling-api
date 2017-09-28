Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # config/routes.rb
  Rails.application.routes.draw do
    resources :games do
      resources :players do
          member do
            post :roll
            get :zeroizeAll
            post :zeroize
          end
      	resources :frames do
        end
      end
    end
  end
end