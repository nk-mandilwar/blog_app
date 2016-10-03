class DashboardController < ApplicationController
  
  def index
    @posts = current_user.following_posts.page params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end   	
end
