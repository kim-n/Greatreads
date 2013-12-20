class SessionsController < ApplicationController

  before_filter :require_no_current_user!, :only => [:create, :new, :request_entry, :mail_request]
  before_filter :require_current_user!, :only => [:destroy]

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if params[:user][:password] == "" || user.nil?
      flash[:errors] = ["Wrong credentials, try again"]
      redirect_to new_session_url
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
    images = [
      "https://identicons.github.com/807d5a1c7facea5fca0692a25dc6d238.png",
      "https://identicons.github.com/glimberg.png",
      "https://identicons.github.com/GrantSolar.png",
      "https://identicons.github.com/gvx.png"
    ]

    params[:user][:password] = ""

    params[:user][:image] = images.shuffle.first

    user = User.new(params[:user])

    if user.save
      msg = UserMailer.activation_email(user)
      msg.deliver!
    end
    redirect_to root_url
  end
end
