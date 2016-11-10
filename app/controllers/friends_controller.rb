class FriendsController < ApplicationController
  before_action :authenticate_user!
	before_action :get_friend, only: :destroy

  def index
  	@friends = current_user.friends
  end

  def destroy
    redirect_to :back unless @friend  
    current_user.remove_friend(@friend)
    respond_to do |format|
      format.html {redirect_to friends_path}
      format.js
    end
  end

  private

  def get_friend
    @friend = current_user.friends.find_by(id: params[:id])                                                                          
  end
end
