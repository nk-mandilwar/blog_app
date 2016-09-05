class FriendRequestsController < ApplicationController
	before_action :set_friend_request, except: [:index, :create, :sent_requests]


	def index
  	@incoming = current_user.received_requests
	end

	def sent_requests
		@outgoing = current_user.requests
	end

  def create
    @friend_request = current_user.friend_requests.new(friend_id: params[:friend_id] )
    @friend_request.save
    redirect_to users_path  
  end

  def destroy
    @friend_request ||= FriendRequest.find_by(friend_id: params[:id])
  	@friend_request.destroy
  	redirect_to users_path 
  end

  def update
	  @friend_request.accept
	  redirect_to friend_requests_path
	end

  private

  def set_friend_request
    @friend_request = FriendRequest.find_by(user_id: params[:id])
  end
end
