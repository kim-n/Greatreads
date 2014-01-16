class HomeController < ApplicationController

  before_filter :require_current_user!

  def index
    @recommendations = current_user.recommendations
    @new = Book.last(5)
    reviews = Post.where(club_id:0).last(5)
    @recently_reviewed = []
    reviews.each do |review|
      @recently_reviewed << review.book
    end
    render :index
  end

end
