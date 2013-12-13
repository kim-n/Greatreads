class SessionsController < ApplicationController
  
  before_filter :require_no_current_user!, :only => [:create, :new, :request_entry, :mail_request]
  before_filter :require_current_user!, :only => [:destroy]

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      render :json => "Credentials were wrong"
    else
      self.current_user = user
      redirect_to root_url
    end
  end

  def destroy
    logout_current_user!
    redirect_to root_url
  end

  def new
    render :new
  end

  def request_entry
    render :request
  end

  def mail_request
    user = User.create(params[:user])
    msg = UserMailer.request_confirm(user)
    msg.deliver!

    redirect_to root_url
  end
end
