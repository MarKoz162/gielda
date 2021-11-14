class UsersController < ApplicationController
  
  def index
    render json: { data: ActiveModel::SerializableResource.new(User.all, each_serializer: UserSerializer) }
  end

  def donate
    @user = User.find(params[:id])
    if @user.update(donate_params)
      render json: @user
    else
      render json: { errors: @user.errors.messages }, status: :unprocessable_entity
    end

  end

  private

  def donate_params
    params.require(:user).permit(:money)
  end

end
