class Notification < ActiveRecord::Base
  attr_accessible :obj_id, :obj_type, :checked, :user_id

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :notifications
  )

  # obj_type:
  # "Post": notify user someone they are following made a new post
  # "Review": notify user someone they are following made a review
  # "Follow": notify user someone is watching them
  # "Club": notify user a post was made in a club they belong to
  # "CommentReply": notify user someone commented on a comment they created
  # "PostReply": notify user someone commented to a post they created

end
