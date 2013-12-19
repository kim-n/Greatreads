class Notification < ActiveRecord::Base
  attr_accessible :obj_id, :obj_type, :checked, :user_id

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :notifications
  )


####---Notifications-----####
  def self.send_notification(new_object, user)
    if new_object.is_a?(Follow)
      Notification.create(user_id: user.id, obj_type: "Follow", obj_id: new_object.id)
    elsif new_object.is_a?(Post)
      Notification.create(user_id: user.id, obj_type: "Post", obj_id: new_object.id)
    elsif new_object.is_a?(Comment)
      Notification.create(user_id: user.id, obj_type: "Comment", obj_id: new_object.id)
    end
  end

end
