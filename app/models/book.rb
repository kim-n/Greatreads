class Book < ActiveRecord::Base
  attr_accessible :title, :author, :isbn, :pic

  has_many(
    :reviews,
    class_name: "Review",
    foreign_key: :book_id,
    primary_key: :id
  )

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
  
end
