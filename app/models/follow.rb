class Follow < ActiveRecord::Base
  attr_accessible :followee_id, :follower_id

  belongs_to(
    :follower,
    class_name: "User",
    foreign_key: :follower_id,
    primary_key: :id,
    inverse_of: :follower_entries
  )

  belongs_to(
    :followee,
    class_name: "User",
    foreign_key: :followee_id,
    primary_key: :id,
    inverse_of: :followee_entries
  )
end
