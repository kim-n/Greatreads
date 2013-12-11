class UsersController < ApplicationController

  def index
    @users = User.all

    render :index
  end

  def create
    user = User.new(params[:user])

    if user.save
      self.current_user = user
      redirect_to user_url(current_user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    render :show
  end

  def new
    render :new
  end
end
