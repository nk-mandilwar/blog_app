class DashboardController < ApplicationController
  
  def index
  	@posts = Post.all.order("updated_at DESC")
  	if (current_user)
  		current_user.following.each do |following|
  			@following_posts = !(@following_posts)? following.posts : @following_posts + following.posts
  		end
  		if(@following_posts)
  			@following_posts.sort! { |a,b| a.updated_at <=> b.updated_at }
  			@following_posts = @following_posts.reverse
  			@posts = @posts - @following_posts
  		end 
  	end 	
  end
end
