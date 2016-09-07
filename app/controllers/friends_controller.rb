class FriendsController < ApplicationController
	before_action :set_friend, only: :destroy
  before_action :authenticate_user!

  def index
  	@friends = current_user.received_friends + current_user.request_friends
  end

  def destroy
    @friend.destroy
    respond_to do |format|
      format.html {redirect_to friends_path}
      format.js
    end
  end

  private

  def set_friend
    @friend = Friendship.find_by(user_id: current_user.id, friend_id: params[:id]) || 
                                Friendship.find_by(user_id: params[:id], friend_id: current_user.id)                                               
  end
end
