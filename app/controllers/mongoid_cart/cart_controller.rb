class MongoidCart::CartController < ActionController::Base

  include MongoidCart::CartHelper

  def show
    @cart = current_cart
  end

  def add_item
    class_name = params[:item][:type]
    item = class_name.constantize.find(params[:item][:id])
    add_to_cart(item)
    redirect_to :back
  end

  def remove_item
    class_name = params[:item][:type]
    item = class_name.constantize.find(params[:item][:id])
    remove_from_cart(item)
    redirect_to :back
  end
end
