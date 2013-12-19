class Follow < ActiveRecord::Base
  attr_accessible :followee_id, :follower_id
  
  belongs_to(
    :user_following,
    class_name: "User",
    foreign_key: :follower_id,
    primary_key: :id,
    inverse_of: :follower_entries
  )
  
  belongs_to(
    :user_being_followed,
    class_name: "User",
    foreign_key: :followee_id,
    primary_key: :id,
    inverse_of: :followee_entries
  )
end
