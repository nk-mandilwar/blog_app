class LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_comment

	def create
		@like = Like.create(comment_id: @comment.id, user_id: current_user.id)
		respond_to do |format|
			format.html {redirect_to post_path(@comment.post)}
			format.js
		end
	end

	def destroy
		@like = Like.find_by(id: params[:id])
    @like.destroy
    respond_to do |f|
			f.html {redirect_to post_path(@comment.post)}
			f.js
		end
  end

	private

		def set_comment
			@comment = Comment.find_by(id: params[:comment_id])
		end
end