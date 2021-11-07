class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]

  # GET /stocks or /stocks.json
  def index
    render json: { data: ActiveModel::SerializableResource.new(Stock.all, each_serializer: StockSerializer) }
  end

  # GET /stocks/1 or /stocks/1.json
  def show
    render json: StockSerializer.new(@stock).to_h
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
    
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)
    @stock.sold_price = 0.8 * @stock.purchase_price
    
    if @stock.save
      render json: @stock
    else
      render json: { errors: @stock.errors.messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    if @stock.update(stock_params)
        render json: @stock
    else
        render json: { errors: @stock.errors.messages }, status: :unprocessable_entity
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    if @stock.destroy
      render json: @stock
    else
      render json: { errors: @stock.errors.messages }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:name, :quantity, :purchase_price)
    end
end
