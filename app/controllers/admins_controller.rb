class AdminsController < ApplicationController

  before_filter :require_current_user!
  before_filter :require_administrator!
  
  def index
    render :index
  end

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

end
