class Book < ActiveRecord::Base
  attr_accessible :title, :author, :isbn, :pic

  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :book_id,
    primary_key: :id
  )

  has_many(
    :club_pairngs,
    class_name: "ClubBook",
    foreign_key: :book_id,
    primary_key: :id,
    inverse_of: :book
  )

  has_many(
    :wish_items,
    class_name: "WishList",
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
    self.posts.where(club_id: 0).select("posts.*, users.name AS username").joins("INNER JOIN users ON posts.user_id=users.id")
  end
end

