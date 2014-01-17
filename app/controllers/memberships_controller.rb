class MembershipsController < ApplicationController
  def create
    membership = Membership.create(user_id: current_user.id, club_id: params[:club_id])
    club = Club.find(params[:club_id])
    
    if request.xhr?
      render partial: "clubs/follow_club", locals: {is_current_user_member: true, club: club, books: club.books} 
    else
      redirect_to club_url(params[:club_id])
    end
  end

  def destroy
    membership = current_user.club_memberships.where(club_id: params[:club_id])[0]
    membership.destroy
    club = Club.find(params[:club_id])
    
    if request.xhr?      
      render partial: "clubs/follow_club", locals: {is_current_user_member: false,  club: club, books: club.books} 
    else
      redirect_to club_url(params[:club_id])
    end
  end
end
