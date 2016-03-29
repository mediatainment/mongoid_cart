class MongoidCart::CartController < ActionController::Base

  def show
    @cart = MongoidCart::Cart.find(cart_id)
  end

  def add_item
    class_name = item_params[:type]
    item = class_name.constantize.find(item_params[:id])
    unless item.add_to_cart.nil?
      message = "Added to cart"
    else
      message = "Already in cart"
    end

    redirect_to :back, notice: message
  end

  def remove_item
    class_name = item_params[:type]
    item = class_name.constantize.find(item_params[:id])
    current_cart.remove(item)
    redirect_to :back
  end

  private

  def item_params
    params.require(:item).permit([:id, :type, :amount, :unit])
  end
end
