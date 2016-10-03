class PublicController < ApplicationController
	def index
		@posts = Post.all.order("updated_at DESC").page params[:page]
		respond_to do |format|
      format.html 
      format.js
    end 	
	end
end
