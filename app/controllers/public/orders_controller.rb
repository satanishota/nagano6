class Public::OrdersController < ApplicationController
  def new
    @order = current_customer.orders.new

  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all
  end

  def create
    @order = current_customer.orders.new(order_params)
    if @order.invalid?
      redirect_to new_order_path
    else
      render :confirm
    end


  end

  def confirm
      @order = current_customer.orders.new(order_params)
   @order.save
   @cart_items = current_customer.cart_items.all
     @cart_items.each do |cart_item|
        @order_details = @order.order_details.new
        @order_details.item_id = cart_item.item.id
        @order_details.amount = cart_item.amount
        @order_details.purchased_price = cart_item.item.price
        @order_details.save

     end
      render :complete


  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_fees,
    :billing_amount, :payment_method)
  end

end
