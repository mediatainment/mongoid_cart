class MongoidCart::CartController < ActionController::Base

  include MongoidCart::ViewHelpers

  def show
    @cart = current_cart
  end

  def add_item
    class_name = params[:type]
    item = class_name.constantize.find(params[:id])
    if item.add_to_cart
      message = ""
    else
      message = ""
    end

    redirect_to :back, notice: message
  end

  def remove_item
    class_name = params[:item][:type]
    item = class_name.constantize.find(params[:item][:id])
    remove_from_cart(item)
    redirect_to :back
  end
end
