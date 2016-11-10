class FriendRequest < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  belongs_to :friend, class_name: 'User'

  def accept
    user.friends << friend
    friend.friends << user
    destroy
  end
end
