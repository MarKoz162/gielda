class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:index,:create]
  
  def index
    render json: { data: ActiveModel::SerializableResource.new(Stock.all, each_serializer: StockSerializer) }
  end

  def show
    render json: StockSerializer.new(@stock).to_h
  end

  def new
    @stock = Stock.new
  end

  def edit
    
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.sold_price = 0.8 * @stock.purchase_price
    
    if @stock.save
      render json: @stock
    else
      render json: { errors: @stock.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @stock.update(stock_params)
        render json: @stock
    else
        render json: { errors: @stock.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @stock.destroy
      render json: @stock
    else
      render json: { errors: @stock.errors.messages }, status: :unprocessable_entity
    end
  end

  private
    def set_stock
      @stock = Stock.find(params[:id])
    end

    def stock_params
      params.require(:stock).permit(:name, :quantity, :purchase_price)
    end
end
