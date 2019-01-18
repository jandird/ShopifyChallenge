Rails.application.routes.draw do
  namespace 'api' do
    get 'show', to: 'shop#show'
    get 'create_cart', to: 'shop#create_cart'
    get 'add_to_cart', to: 'shop#add_to_cart'
    get 'view_cart', to: 'shop#view_cart'
    get 'complete_cart', to: 'shop#complete_cart'
  end
end
