class FriendRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def accept
    user.request_friends << friend
    destroy
  end
end
