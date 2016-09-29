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
    if @relationship.follower_id != current_user.id
      redirect_to :back, notice: "You can't unfollow user that you are not following."
    else  
      @relationship.destroy
      respond_to do |format|
        format.html {redirect_to users_path}
        format.js
      end
    end  
  end
end
