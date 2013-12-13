class AdminsController < ApplicationController
  before_filter :require_administrator!


  def users
    @users = User.valid_users
    render :users
  end

  def clubs
    @clubs = Club.all
    render :clubs
  end

  def activation
    @requests = User.requests
    @pending = User.pending
  end

  def index
    render :index
  end

end
