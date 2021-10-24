class Public::CartItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      redirect_to cart_items_path
    else
      render :show
    end

  end

  def update
     @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end

  end


  def destroy
  end

  def destroy_all
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end
