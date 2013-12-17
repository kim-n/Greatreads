class Comment < ActiveRecord::Base
  attr_accessible :body, :parent_id, :post_id, :user_id

  validates :body, :parent_id, :post_id, :user, presence: true

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id
  )

  belongs_to(
    :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id
  )

  has_many(
    :children_comments,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id
  )

end
