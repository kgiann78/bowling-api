Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # config/routes.rb
  Rails.application.routes.draw do
    resources :games do
      resources :players do
      	resources :frames do
          member do
            post :roll
            post :update
            get :show
            delete :destroy
          end
        end
      end
    end
  end
end