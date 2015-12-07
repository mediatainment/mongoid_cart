Rails.application.routes.draw do

  resources :products


  mount MongoidCart::Engine => "/mongoid_cart"
end
