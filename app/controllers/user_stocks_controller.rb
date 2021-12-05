class UserStocksController < ApplicationController
  before_action :set_stock, only: [:create, :sell]
  skip_before_action :authenticate_user!, only: [:index]
  def index
    render json: { data: ActiveModel::SerializableResource.new(UserStock.all, each_serializer: UserStockSerializer) }
  end


  def create
    if @stock.quantity >= params[:quantity]
      if current_user.money >= params[:quantity] * @stock.purchase_price
        if UserStock.where(user_id: current_user.id, stock_id: params[:stock_id]).empty?
          @user_stocks = UserStock.create(user: current_user, stock: @stock, quantity: params[:quantity])
          if @user_stocks.save
            subtract_money_and_quantity(params[:quantity])
          else
            render json: { errors: @user_stocks.errors.messages }, status: :unprocessable_entity
          end 
        else
          @user_stocks = UserStock.find_by(user_id: current_user, stock_id: @stock.id) 
          if @user_stocks.update(quantity: @user_stocks.quantity + params[:quantity])
            subtract_money_and_quantity(params[:quantity])
          else
            render json: { errors: @user_stocks.errors.messages }, status: :unprocessable_entity
          end
        end
      else
        render json: { errors: "You don't have enough money" }, status: :unprocessable_entity
      end  
    else
      render json: { errors: "We don't have enough stock to sell " }, status: :unprocessable_entity
    end
  end


  def sell
    if UserStock.where(user_id: current_user.id, stock_id: params[:stock_id]).empty?
      render json: { errors: "You didn't buy any stock with such an id" }, status: :unprocessable_entity
    else
      @user_stock = UserStock.find_by(user_id: current_user, stock_id: @stock.id) 
      if @user_stock.quantity >= params[:quantity]
        if @user_stock.update(quantity: @user_stock.quantity - params[:quantity])
          add_money_and_quantity(-params[:quantity])
          if @user_stock.quantity == 0
            @user_stocks.destroy
            render json: @user_stock
          else
            render json: @user_stock
          end
        else
          render json: { errors: @user_stock.errors.messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: "You don't own that many stocks" }, status: :unprocessable_entity
      end
    end
  end

  private

  def set_stock
    @stock = Stock.find(params[:stock_id])
  end

  def subtract_money_and_quantity(quantity)
    current_user.calculate_money(-quantity * @stock.purchase_price)
    @stock.calculate_quantity(-quantity)
    @stock.calculate_price(quantity)
    render json: @user_stocks
  end

  def add_money_and_quantity(quantity)
    current_user.calculate_money(-quantity * @stock.sold_price)
    @stock.calculate_quantity(-quantity)
    @stock.calculate_price(quantity)
  end

end
