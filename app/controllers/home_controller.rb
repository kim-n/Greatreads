class HomeController < ApplicationController

  before_filter :require_current_user!, only: [:index]

  def index
    @books = Book.all
    @clubs = Club.all
  end

  def setupdb

    @fin = "Finished"
  end
end
