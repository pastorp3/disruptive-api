class UsersController < ApplicationController
  before_action :find_user, only: [:login]
  before_action :set_user, only: [:get_user]

  def create
    user = User.new(user_params)
    user.password = params[:password]
    if user.save!
      render :json => user 
    else
      render user.errors.to_json
    end
  end

  def login
    if @user && @user.authenticate(params[:password])
      render :json => @user
    else
      render  status: :unprocessable_entity
    end
  end

  def get_user
    if @user
      render :json => @user.wallet
    else
      render status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def find_user
    @user = User.find_by(email: params[:email])
  end

  def set_user
    @user = User.find(params[:id])
  end
end