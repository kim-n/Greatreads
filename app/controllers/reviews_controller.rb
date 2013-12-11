class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.new(params[:review])

    @review.book_id = params[:book_id]


    if @review.save
      book = Book.find(params[:book_id])
      redirect_to book_url(book.isbn)
    else
      render :json => "something went wrond"
    end
  end
end
