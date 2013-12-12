class BooksController < ApplicationController

  before_filter :require_current_user!

  def index
    @books = Book.all
    render :index
  end

  def show
    @book = Book.find_by_isbn(params[:id])
    @posts = @book.reviews.select("reviews.*, users.name AS username, users.id AS userid").joins("INNER JOIN users ON reviews.user_id=users.id")
    render :show
  end
end

