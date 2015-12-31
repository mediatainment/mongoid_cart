MongoidCart::Engine.routes.draw do

    match 'add_item' => 'cart#add_item', via: [:get, :post]
    match 'remove_item' => 'cart#remove_item', via: [:get, :post]
    match 'show' => 'cart#show', via: [:get, :post]
end
