class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all
  end

  def create
    @order = Order.new(order_params)
   
    if @order.invalid?
      redirect_to new_order_path
    else
      render :confirm
    end


  end

  def confirm
    @order = Order.new(order_params)
    if @order.save
      render :complete
    else
      render :new
    end
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_fees,
    :billing_amount, :payment_method)
  end

end
