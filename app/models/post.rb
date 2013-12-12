class Post < ActiveRecord::Base
  attr_accessible :book_id, :club_id, :user_id, :body, :title

  validates :book, :club, :user, :body, presence: true

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :book,
    class_name: "Book",
    foreign_key: :book_id,
    primary_key: :id
  )

  belongs_to(
    :club,
    class_name: "Club",
    foreign_key: :club_id,
    primary_key: :id
  )

end
