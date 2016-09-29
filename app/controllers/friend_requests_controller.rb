class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
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
    if @friend_request.user_id != current_user.id || @friend_request.friend_id != current_user.id
      redirect_to :back, "You can't reject the request that you didnt send or receive."
    else 
    	@friend_request.destroy
    	respond_to do |format|
        format.html {redirect_to :back}  
        format.js
      end
    end   
  end

  def update
    if @friend_request.friend_id != current_user.id
      redirect_to :back, "You can't accept the request that you didnt receive."
    else
  	  @friend_request.accept
      respond_to do |format|
  	    format.html {redirect_to friend_requests_path}
        format.js
      end
    end  
	end

  private

  def set_friend_request
    @friend_request = FriendRequest.find_by(user_id: params[:id])
  end
end
