class ClubsController < ApplicationController

  before_filter :require_current_user!, except: [:index, :show]

  def index
    @clubs = Club.all
    render :index
  end

  def create
    params[:club][:books_ids].delete("")
    if params[:club][:books_ids].empty?
      flash[:errors] = ["Clubs must have atleast 1 book"]
      redirect_to new_club_url
    else
      club = current_user.created_clubs.new(params[:club])
      if club.save
        redirect_to club_url(club)
      else
        flash[:errors] = club.errors.full_messages
        render :new
      end
    end
  end

  def show
    @club = Club.find_by_id(params[:id])

    if @club
      @posts = @club.posts
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



  def new
    @books = Book.all
    render :new
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
