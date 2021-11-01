class Public::OrdersController < ApplicationController
  def new
    @order = current_customer.orders.new

  end

  def show
    @order = Order.find(params[:id])

  end

  def index
    @orders = current_customer.orders.all
  end

  def create
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
    current_customer.cart_items.destroy_all
  redirect_to orders_complete_path


  end

  def confirm
      @order = Order.new(order_params)
      @order.payment_method = params[:order][:payment_method]
      @order.shipping_fees = params[:order][:shipping_fees]
      @order.customer_id = params[:order][:customer_id]

      if params[:order][:select_address] == "0"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.first_name + current_customer.last_name
      elsif params[:order][:select_address] == "1"
        @address = Address.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      else
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
      end

      @cart_items = current_customer.cart_items
  render :confirm
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:shipping_fees,:billing_amount, :payment_method, :name, :customer_id ,:postal_code, :address )
  end

end
