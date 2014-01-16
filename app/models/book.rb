class Book < ActiveRecord::Base
  attr_accessible :title, :author, :isbn, :pic, :description

  has_many(
    :post_items,
    class_name: "Post",
    foreign_key: :book_id,
    primary_key: :id
  )

  has_many(
    :club_pairings,
    class_name: "ClubBook",
    foreign_key: :book_id,
    primary_key: :id,
    inverse_of: :book
  )
  
  has_many(
    :tastes,
    class_name: "Like",
    foreign_key: :book_id,
    primary_key: :id
  )
  
  def likes
    self.tastes.where(taste: 1)
  end 
  
  def dislikes
    self.tastes.where(taste: -1)
  end

  def reviews
    Post.book_reviews(self.id)
  end
end

