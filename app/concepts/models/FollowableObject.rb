module FollowableObject
  attr_accessor :followed_ids

  def addFollower(followed_id)
     @followed_ids << followed_id
  end
end
