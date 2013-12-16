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
    comment.parent_id = 0
    

    if comment.save
      redirect_to comments_url
    else
      flash[:errors] = comment.errors.full_messages
      redirect_to comments_url
    end
  end
  
  def index
    @comments = Comment.where(parent_id: 0)
    render :index
  end
end
