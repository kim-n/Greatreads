class FollowsController < ApplicationController
  def create
    current_user.followed_members.create(followee_id: params[:user_id])
    redirect_to user_url(params[:user_id])
  end
  
  def destroy
    follow = Follow.where(followee_id: params[:user_id], follower_id: current_user.id)[0]
    follow.destroy
    redirect_to user_url(params[:user_id])
  end
end
