class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id
		@comment.save
		if @comment.parent_id 
			@c = Comment.find(@comment.parent_id) 
			redirect_to post_comment_path(@post, @c)
		else
			redirect_to post_path(@post)
		end
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
			params.require(:comment).permit(:content, :parent_id, :base_id)
		end
end