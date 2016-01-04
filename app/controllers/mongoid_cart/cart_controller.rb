class MongoidCart::CartController < ActionController::Base

  include MongoidCart::ViewHelpers

  def show
    @cart = current_cart
  end

  def add_item
    class_name = params[:item][:type]
    item = class_name.constantize.find(params[:item][:id])
    unless item.add_to_cart.nil?
      message = "Added to cart"
    else
      message = "Already in cart"
    end

    redirect_to :back, notice: message
  end

  def remove_item
    class_name = params[:item][:type]
    item = class_name.constantize.find(params[:item][:id])
    item.remove_from_cart
    redirect_to :back
  end
end
