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
    @book = Book.find(params[:book_id])
    
    
    if request.xhr?
      
      @posts = @book.reviews.find(:all)

      @book_rating = Like.find_rating(current_user.id, @book.id)
      @current_user_review = Post.review_for(current_user.id, @book.id)
      @posts.delete(@current_user_review)

      @like_count = @book.likes.count
      @dislike_count = @book.dislikes.count
      
      render partial: "likes/list_likes", locals: {book: @book, is_reviewed: @current_user_review, book_rating: @book_rating, dislike_count: @dislike_count, like_count: @like_count} 
    else
      redirect_to book_url(@book.isbn)
    end
  end
  
  def destroy
    rating = Like.find_rating(current_user.id, params[:book_id] )
    @book = Book.find(params[:book_id])
    rating.destroy


    if request.xhr?
      
      @posts = @book.reviews.find(:all)

      @book_rating = Like.find_rating(current_user.id, @book.id)
      @current_user_review = Post.review_for(current_user.id, @book.id)
      @posts.delete(@current_user_review)

      @like_count = @book.likes.count
      @dislike_count = @book.dislikes.count
      
      render partial: "likes/list_likes", locals: {book: @book, is_reviewed: @current_user_review, book_rating: @book_rating, dislike_count: @dislike_count, like_count: @like_count} 
    else
      redirect_to book_url(@book.isbn)
    end
  end
end
