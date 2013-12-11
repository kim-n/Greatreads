class Review < ActiveRecord::Base
  attr_accessible :book_id, :user_id, :body, :title

  validates :book_id, :user, :body, presence: true

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

end
