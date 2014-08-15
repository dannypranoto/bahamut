class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to register_success_path
    else
      render 'register'
    end
  end

  def register
    @user = User.new
  end

  private
    def user_params
      params.require(:user).permit(:name, :phone_number, :email, :password, :password_confirmation)
    end
end
