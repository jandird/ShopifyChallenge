Rails.application.routes.draw do
  namespace 'api' do
    get 'show', to: 'shop#show'
  end
end
