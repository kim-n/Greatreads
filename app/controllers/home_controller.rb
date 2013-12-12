class HomeController < ApplicationController

  before_filter :require_current_user!

  def index
    @books = Book.all
    @clubs = Club.all
  end

end
