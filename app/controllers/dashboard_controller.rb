class DashboardController < ApplicationController
  
  def index
    if !current_user 
  	  @posts = Post.all.order("updated_at DESC").page params[:page]
    else
      @posts = current_user.following_posts.page params[:page]
    end    
    respond_to do |format|
      format.html
      format.js
    end 	
  end
end
