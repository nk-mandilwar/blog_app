class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
	before_action :get_friend_request, except: [:index, :create, :sent_requests]


	def index
  	@incoming = current_user.received_requests
	end

	def sent_requests
		@outgoing = current_user.requests
	end

  def create
    @friend_request = current_user.friend_requests.new(friend_id: params[:friend_id] )
    @friend_request.save
    @user = User.find_by(id: @friend_request.friend_id)
    respond_to do |format|
      format.html {redirect_to users_path}
      format.js
    end
  end

  def destroy
    @friend_request ||= FriendRequest.find_by(friend_id: params[:id])
    @user = User.find_by(id: @friend_request.friend_id)
    redirect_to :back unless @friend_request
    if @friend_request.user_id != current_user.id && @friend_request.friend_id != current_user.id
      @notice = "You can't reject the request that you didnt send or receive."
    else
    	@friend_request.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    redirect_to :back unless @friend_request
    if @friend_request.friend_id != current_user.id
      @notice = "You can't accept the request that you didnt receive."
    else
  	  @friend_request.accept
    end
    respond_to do |format|
      format.js
    end
	end

  private

  def get_friend_request
    @friend_request = FriendRequest.find_by(user_id: params[:id])
  end
end
