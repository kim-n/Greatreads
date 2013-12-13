class LikesController < ApplicationController
  
  before_filter :require_current_user!
  
  def create
    @like = Like.find_rating(current_user.id, params[:book_id])
    
    if @like.nil?
      current_user.tastes.create(
        book_id: params[:book_id],
        taste: params[:taste]
      )
    else
      @like.update_attributes(taste: params[:taste])
    end
    book = Book.find(params[:book_id])
    
    redirect_to book_url(book.isbn)
  end
  
  def destroy
    rating = Like.find_rating(current_user.id, params[:book_id] )
    book = Book.find(params[:book_id])
    rating.destroy

    redirect_to book_url(book.isbn)
  end
end
