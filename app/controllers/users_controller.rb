class UsersController < ApplicationController
  
  before_filter :require_current_user!
    
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
    @reviews = @user.reviews.select("reviews.*, books.title AS bookname, books.isbn AS bookisbn").joins("INNER JOIN books ON reviews.book_id=books.id")
    @posts = @user.posts.select("posts.*, books.title AS bookname").joins("INNER JOIN books ON posts.book_id=books.id")
    @wishes = @user.wish_books
    @reads = @user.readBooks
    render :show
  end

  def new
    render :new
  end
end
