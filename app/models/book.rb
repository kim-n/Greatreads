class Book < ActiveRecord::Base
  attr_accessible :title, :author, :isbn, :pic

  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :book_id,
    primary_key: :id
  )

  has_many :reviewers, through: :posts, source: :user
end
