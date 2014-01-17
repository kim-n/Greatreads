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
    primary_key: :id,
    dependent: :destroy
  )


  def notify_user_responding_to
    unless self.parent_id == 0 #comment is a reply to another comment
      unless parent_comment.user_id == self.user_id
        Notification.create(
          user_id: self.parent_comment.user_id,
          obj_type: "CommentReply",
          obj_id: self.id
        )
      end
    else #comment is a reply to a post
    # Notify post author
    unless post.user_id == self.user_id
        Notification.create(
          user_id: self.post.user_id,
          obj_type: "PostReply",
          obj_id: self.id
        )
      end
    end
  end

end
