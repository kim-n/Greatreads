class WishList < ActiveRecord::Base
  attr_accessible :user_id, :book_id

  validates :user_id, :book_id, presence: true

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :wish_items
  )

  belongs_to(
    :book,
    class_name: "Book",
    foreign_key: :book_id,
    primary_key: :id,
    inverse_of: :wish_items
  )
end
