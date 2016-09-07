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
    respond_to do |format|
      format.html {redirect_to users_path}  
      format.js
    end
  end

  def destroy
    @friend_request ||= FriendRequest.find_by(friend_id: params[:id])
  	@friend_request.destroy
  	respond_to do |format|
      format.html {redirect_to :back}  
      format.js
    end 
  end

  def update
	  @friend_request.accept
    respond_to do |format|
	    format.html {redirect_to friend_requests_path}
      format.js
    end
	end

  private

  def set_friend_request
    @friend_request = FriendRequest.find_by(user_id: params[:id])
  end
end
