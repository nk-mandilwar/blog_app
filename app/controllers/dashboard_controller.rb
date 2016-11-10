class DashboardController < ApplicationController
  
  def index
    @posts = current_user.following_blogs.order('created_at DESC').page params[:page]
    respond_to do |format|
      format.html
      format.js
    end 	
  end  

end
