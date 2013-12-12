class ReviewsController < ApplicationController

  before_filter :require_current_user!
  before_filter :no_double_review!
  def create
    @review = current_user.reviews.new(params[:review])

    @review.book_id = params[:book_id]

    if @review.save
      book = Book.find(params[:book_id])
      redirect_to book_url(book.isbn)
    else
      render :json => "something went wrong"
    end
  end

  def no_double_review!
    book = Book.find(params[:book_id])
    @review = Review.find_by_user_id_and_book_id(current_user.id, book.id)
    render :json => "Can't double review" unless @review.nil?
  end

end
