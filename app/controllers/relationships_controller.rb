class RelationshipsController < ApplicationController
	before_action :authenticate_user!

  def create
    @relationship = Relationship.create(follower_id: current_user.id, followed_id: params[:followed_id])
    @relationship.save
    respond_to do |format|
      format.html {redirect_to users_path}
      format.js
    end
  end

  def destroy
    @relationship = Relationship.find_by(id: params[:id])
    redirect_to :back unless @relationship
    if @relationship.follower_id != current_user.id
      @notice = "You can't unfollow user that you are not following."
    else  
      @relationship.destroy
    end
    respond_to do |format|
      format.html {redirect_to users_path}
      format.js
    end  
  end
end
