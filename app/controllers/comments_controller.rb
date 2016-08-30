class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only: [:destroy, :create]
	
	def create
		@comment = Comment.create(comment_params.merge({post_id: @post.id, user_id: current_user.id}))
		if @comment.parent_id 
			@c = Comment.find(@comment.parent_id) 
			@c.no_of_children += 1
			@c.save
		end
		respond_to do |format|
			format.html {redirect_to post_path(@post)}
			format.js
		end
	end

	def destroy
		@comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
    	format.html {redirect_to post_path(@post)}
    	format.js
    end
  end

  def liked_by
  	@comment = Comment.find(params[:id])
  	@users = @comment.liked_by
  end

	private

		def comment_params
			params.require(:comment).permit(:content, :parent_id, :base_id, :level)
		end

		def set_post
			@post = Post.find_by(:id => params[:post_id])
		end
end