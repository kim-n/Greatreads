class AdminsController < ApplicationController
  before_filter :require_administrator!
  
  
  def users
    @users = User.all
    render :users
  end
  
  def clubs
    @clubs = Club.all 
    render :clubs
  end
  
  
  def activation
    
  end
  
  def index
    
  end
  
end
