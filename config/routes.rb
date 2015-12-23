MongoidCart::Engine.routes.draw do

    post 'add_item' => 'cart#add_item'
    post 'remove_item' => 'cart#remove_item'
    get 'show' => 'cart#show'
end
