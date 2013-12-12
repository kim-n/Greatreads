class ClubsController < ApplicationController

  def index
    @clubs = Club.all
    render :index
  end

  def create
    club = current_user.created_clubs.new(params[:club])

    if club.save
      redirect_to club_url(club)
    else
      render :json => "error"
    end
  end

  def show
    @club = Club.find(params[:id])
    @posts = @club.posts
    render :show
  end

  def new
    render :new
  end
end
