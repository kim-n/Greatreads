class PostsController < ApplicationController

  before_filter :require_current_user!

  def create
    post = current_user.posts.new(params[:post])
    post.club_id = params[:club_id]

    unless post.save
      flash[:errors] = post.errors.full_messages
    end
    
    redirect_to club_url(params[:club_id])
  end
end
