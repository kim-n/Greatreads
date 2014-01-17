class ClubsController < ApplicationController

  before_filter :require_current_user!, except: [:index, :show]
  before_filter :require_admin_status!, only: [:create]
  def index
    @clubs = Club.find(:all, :order => "created_at DESC")
    render :index
  end

  def create
    params[:books_ids].delete("")
    if params[:books_ids].empty?
      flash.now[:errors] = ["Clubs must have atleast 1 book"]
      if request.xhr?
        render json: flash[:errors], status: :unprocessable_entity
      else
        redirect_to clubs_url
      end
    else
      club = nil
      is_saved = false
      begin
        Club.transaction do
          club = current_user.created_clubs.new(params[:club])
          is_saved = club.save!
          params[:books_ids].each do |book_id|
            club.book_pairings.create!(book_id: book_id)
          end
        end

        if request.xhr?
          render partial: "list_clubs", locals: {clubs: Club.find(:all, :order => "created_at DESC")}
        else
          redirect_to club_url(club)
        end
      rescue ActiveRecord::RecordInvalid => invalid
        if request.xhr?
          render json: club.errors.full_messages, status: :unprocessable_entity
        else
          flash[:errors] = club.errors.full_messages
          redirect_to clubs_url
        end
      end
    end
  end

  def show
    @club = Club.find_by_id(params[:id])

    if @club
      @is_current_user_member = current_user.nil? ? false : current_user.club_memberships.where(club_id: @club.id)[0]
      @posts = @club.posts.find(:all, :order => "created_at DESC")
      @clubbooks = @club.books
      render :show
    else
      flash[:errors] = ["Invalid club url"]
      redirect_to clubs_url
    end
  end

  def filter_show
    @club = Club.find_by_id(params[:club_id])
    if params[:book_id] == "0"
      @posts = @club.posts
    else
      @posts = @club.posts.where(book_id: params[:book_id])
    end
    render partial: "posts/list_posts", locals:{posts: @posts, club_page: "hide-tag"}
  end

  def add_book
    club = Club.find_by_id(params[:club_id])
    club_book = club.book_pairings.create(book_id: params[:books_ids].first)
    
    redirect_to club_url(club)
  end

  def destroy
    club = Club.find(params[:id])

    if is_administrator?(current_user) || current_user.id == club.creator.id
      flash[:errors] = ["#{club.title} destroyed!"]
      club.destroy
      redirect_to clubs_admin_url
    else
      flash[:errors] = ["Must be club owner to delete!"]
      redirect_to club_url(club)
    end
  end
end
