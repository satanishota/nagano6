class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @order = Order.new
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
    @cart_items = CartItem.find(params[:id])
    @cart_items.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_items = CartItem.find(params[:id])
    @cart_items.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
