class UsersController < ApplicationController

  before_filter :require_current_user!, except: [:update, :new, :index, :show]
  before_filter :require_no_current_user!, only: [:update, :new]
  # before_filter :require_administrator!, only: [:create, :new]


  def index
    @users = User.valid_users.find(:all, :order => "name DESC")
    render :index
  end
  #
  # def create
  #   user = User.new(params[:user])
  #
  #   if user.save
  #     self.current_user = user
  #     redirect_to user_url(current_user)
  #   else
  #     render :new
  #   end
  # end

  def update
    user = User.find_by_session_token(params[:id])
    if (user.email == params[:user][:email])
      params[:user][:admin] = 0
      user.update_attributes(params[:user])
      log_in(user)

      redirect_to root_url
    else
      flash[:errors] = ["Emails don't match"]
      redirect_to new_user_url({activation_token: params[:id]})
    end

  end

  def show
    @user = User.find_by_id(params[:id])

    if @user
      @reviews = @user.reviews
      @posts = @user.post_items
      @wishes = @user.wish_books
      @read_books_with_rating = @user.read_books_with_rating
      @is_followed_by_current_user = current_user.nil? ? false : current_user.follows.where(id: @user.id)[0]
      render :show
    else
      flash[:errors] = ["Invalid user page"]
      redirect_to users_url
    end
  end

  def new
    render :new
  end

  def destroy
    user = User.find(params[:id])
    if user.id == current_user.id
        flash[:errors] = ["Can't destroy self"]
    else
      user.destroy
    end
    redirect_to users_admin_url
  end

  def send_activation_email
    user = User.find(params[:user_id])
    user.reset_session_token!
    msg = UserMailer.activation_email(user)
    msg.deliver!

    redirect_to requests_admin_url
  end

  # def activate
  #   user = User.find(params[:id])
  #   user.activated = true
  #   user.save!
  #
  #   sign_in(user)
  #   redirect_to user_path(user)
  # end

end
