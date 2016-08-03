class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		
		@comment.save
		if @comment.parent_id 
			@c = Comment.find(@comment.parent_id) 
			@c.no_of_children += 1
			@c.save
		end
			redirect_to post_path(@post)
	end

	def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

	def show
		@post = Post.find(params[:post_id])
	    @comment = @post.comments.find(params[:id])
	end

	private

		def comment_params
			params.require(:comment).permit(:content, :parent_id, :base_id, :level)
		end
end