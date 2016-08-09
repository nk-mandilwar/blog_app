class CommentsController < ApplicationController
	before_action :set_post, only: [:create, :show, :destroy]
	before_action :authenticate_user!
	
	def create
		@comment = Comment.create(comment_params.merge({post_id: @post.id, user_id: current_user.id}))
		if @comment.parent_id 
			@c = Comment.find(@comment.parent_id) 
			@c.no_of_children += 1
			@c.save
		end
			redirect_to post_path(@post)
	end

	def destroy
		@comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

	def show
	   @comment = @post.comments.find(params[:id])
	end

	private

		def comment_params
			params.require(:comment).permit(:content, :parent_id, :base_id, :level)
		end

		def set_post
			@post = Post.find(params[:post_id])
		end
end