class ClubsController < ApplicationController

  before_filter :require_current_user!

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
    @posts = @club.posts.select("posts.*, users.name AS username, books.title AS bookname").joins("INNER JOIN users ON posts.user_id=users.id").joins("INNER JOIN books ON posts.book_id=books.id")
    @books = Book.all
    @clubbooks = @club.books
    render :show
  end

  def new
    render :new
  end
end
