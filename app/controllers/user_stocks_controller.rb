class UserStocksController < ApplicationController
  

  def donate
    @user = User.find(params[:id])
    @user.money = @user.money + params[:money]
    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors.messages }, status: :unprocessable_entity
    end
  end


end
