Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # config/routes.rb
  Rails.application.routes.draw do
    resources :games do
      resources :players do
      	resources :frames
      end
    end
  end
end

  #   resources :games do
  #     resources :players
  #   end
  #   resources :players do
  # 	  resources :frames
  #   end
  # end