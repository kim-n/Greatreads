class Post < ActiveRecord::Base
  attr_accessible :book_id, :club_id, :user_id, :body, :title

  validates :book, :user, :body, presence: true

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

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id
  )

  def top_level_comments
    self.comments.where(parent_id: 0).select("comments.*, users.name AS username").joins("INNER JOIN users ON comments.user_id=users.id")
  end

  def self.review_for(current_user_id, book_id)
    Post.where("club_id = ? AND user_id = ? AND book_id = ?", 0, current_user_id, book_id)[0]
  end

  def self.book_reviews(book_id)
    Post.where("club_id = ? AND book_id = ? ", 0, book_id).select("posts.*, users.name AS username").joins("INNER JOIN users ON posts.user_id=users.id")
  end

  def self.user_reviews(user_id)
    Post.where("club_id = ? AND user_id = ? ", 0, user_id).includes(:book)
  end

  def self.user_posts(user_id)
    Post.where("club_id <> ? AND user_id = ? ", 0, user_id).includes(:book)
  end
end
