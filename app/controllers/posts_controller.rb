class PostsController < ApplicationController

  before_filter :require_current_user!

  def create
    post = current_user.posts.new(params[:post])
    post.club_id = params[:club_id]

    if post.save
      redirect_to club_url(params[:club_id])
    else
      render :json => "error creating new post"
    end
  end
end
