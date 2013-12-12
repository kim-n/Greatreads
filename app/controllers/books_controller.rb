class BooksController < ApplicationController

  before_filter :require_current_user!

  def index
    @books = Book.all
    render :index
  end

  def show
    @book = Book.find_by_isbn(params[:id])
    @wish = WishList.find_by_user_id_and_book_id(
      current_user.id,
      @book.id
    )
    @posts = @book.reviews.select("reviews.*, users.name AS username, users.id AS userid").joins("INNER JOIN users ON reviews.user_id=users.id")
    render :show
  end
end

