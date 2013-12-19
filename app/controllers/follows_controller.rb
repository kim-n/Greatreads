class FollowsController < ApplicationController
  def create
    # current_user.followed_members.create(followee_id: params[:user_id])
    follow = Follow.create(followee_id: params[:user_id], follower_id: current_user.id)
    Notification.create(user_id: params[:user_id], obj_type: "Follow", obj_id: follow.id)

    redirect_to user_url(params[:user_id])
  end

  def destroy
    follow = Follow.where(followee_id: params[:user_id], follower_id: current_user.id)[0]
    follow.destroy

    redirect_to user_url(params[:user_id])
  end
end
