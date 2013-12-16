class PostsController < ApplicationController

  before_filter :require_current_user!
  before_filter :no_double_review!, only: [:create_review]
  

  def create
    post = current_user.posts.new(params[:post])
    post.club_id = params[:club_id]

    unless post.save
      flash[:errors] = post.errors.full_messages
    end
    
    redirect_to club_url(params[:club_id])
  end
  
  def create_review
    @review = current_user.posts.new(params[:post])

    @review.book_id = params[:book_id]
    @review.club_id = 0
    
    unless @review.save
      flash[:errors] = @review.errors.full_messages
    end

    book = Book.find(params[:book_id])
    redirect_to book_url(book.isbn)
  end

  def no_double_review!
    book = Book.find(params[:book_id])
    @review = Post.review_for(current_user.id, book.id)
    
    unless @review.nil?
      flash[:errors] = ["Can't double review"]
      redirect_to book_url(book.isbn)
    end
  end
  
  
end
