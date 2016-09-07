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
    @relationship.destroy
    respond_to do |format|
      format.html {redirect_to users_path}
      format.js
    end
  end
end
