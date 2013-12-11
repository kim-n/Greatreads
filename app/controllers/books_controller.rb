class BooksController < ApplicationController

  def index
    @books = Book.all
    render :index
  end

  def show
    @book = Book.find_by_isbn(params[:id])
    @posts = @book.posts.select("posts.*, users.name AS username, users.id AS userid").joins("INNER JOIN users ON posts.user_id=users.id")
    render :show
  end
end

