class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    render json: { data: ActiveModel::SerializableResource.new(User.all, each_serializer: UserSerializer) }
  end

  def donate
    @user = User.find(params[:id])
    @user.money = @user.money + params[:money]
    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors.messages }, status: :unprocessable_entity
    end

  end

  private


end
