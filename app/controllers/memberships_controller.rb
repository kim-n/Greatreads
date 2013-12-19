class MembershipsController < ApplicationController
  def create
    Membership.create(user_id: current_user.id, club_id: params[:club_id])
    redirect_to club_url(params[:club_id])
  end

  def destroy
    membership = current_user.club_memberships.where(club_id: params[:club_id])[0]
    membership.destroy
    redirect_to club_url(params[:club_id])
  end
end
