class UsersController < ApplicationController
  def index
    authorize User
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
    authorize User
    @user.blocked = !@user.blocked
    @user.save!
    redirect_to user_path(@user)
  end
end
