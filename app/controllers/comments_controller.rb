class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    comment = current_user.comments.new(params[:comment])
    comment.post_id = params[:post_id]
    comment.parent_id = params[:parent_id]



    is_saved = comment.save

    unless is_saved
      flash[:errors] = comment.errors.full_messages
    end

    if request.xhr?
      if is_saved
        render partial: "comments/comment", locals: {comment: comment}
      else
        render json: comment.errors.full_messages, status: :unprocessable_entity
      end
    else
      redirect_to book_url(comment.post.book.isbn)
    end
  end

  def index
    @comments = Comment.where(parent_id: 0)
    render :index
  end
end
