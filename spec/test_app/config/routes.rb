Rails.application.routes.draw do

  resources :users

  resources :products


  mount MongoidCart::Engine => "/mongoid_cart"
end
