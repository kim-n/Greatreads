class ReviewsController < ApplicationController

  before_filter :require_current_user!
  before_filter :no_double_review!
  
  def create
    @review = current_user.reviews.new(params[:review])

    @review.book_id = params[:book_id]

    unless @review.save
      flash[:errors] = club.errors.full_messages
    end
    
    book = Book.find(params[:book_id])
    redirect_to book_url(book.isbn)
    
  end

  def no_double_review!
    book = Book.find(params[:book_id])
    @review = Review.find_by_user_id_and_book_id(current_user.id, book.id)
    flash[:errors] = ["Can't double review"] unless @review.nil?
    redirect_to book_url(book.isbn)
  end

end
