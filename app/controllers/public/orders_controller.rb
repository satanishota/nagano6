class Public::OrdersController < ApplicationController
  def new
    @oredr = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @ad = current_customer.addresses

    @order.postal_code = @ad.postal_code
    @order.address = @ad.address
    @order.name = @ad.name
    @order.shipping_fees = 800
    if @order.save
      redirect_to orders_path(@order.id)
    else
      render :show
    end

  end

  def comfirm
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_fees,
    :billing_amount, :payment_method)
  end

end
