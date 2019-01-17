Rails.application.routes.draw do
  namespace 'api' do
    get 'show', to: 'shop#show'
    get 'create_cart', to: 'shop#create_cart'
    get 'add_to_cart', to: 'shop#add_to_cart'
  end
end
