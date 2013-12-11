class BooksController < ApplicationController

  def index
    @books = Book.all
    render :index
  end

  def show
    @book = Book.find_by_isbn(params[:id])
    render :show
  end
end
