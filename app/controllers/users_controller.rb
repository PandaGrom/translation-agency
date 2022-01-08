class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
    @user.blocked = !@user.blocked
    @user.save!
    redirect_to user_path(@user)
  end
end
