class LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :get_comment

	def create
		@like = Like.create(comment_id: @comment.id, user_id: current_user.id)
		respond_to do |format|
			format.js
		end
	end

	def destroy
		@like = Like.find_by(id: params[:id])
		redirect_to :back unless @like
		if @like.user != current_user
			@notice = "Cannot access other user's like page"
    else
    	@like.destroy
    end
    respond_to do |format|
			format.js
		end
  end

	private

		def get_comment
			@comment = Comment.find_by(id: params[:comment_id])
			redirect_to :back unless @comment
		end
end
