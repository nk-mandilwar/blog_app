class FriendsController < ApplicationController
	before_action :set_friend, only: :destroy
  before_action :authenticate_user!

  def index
  	@friends = current_user.friends
  end

  def destroy
    current_user.friends.destroy(@friend)
    @friend.friends.destroy(current_user)
    redirect_to friends_path
  end

  private

  def set_friend
    @friend = current_user.friends.find(params[:id])
  end
end
