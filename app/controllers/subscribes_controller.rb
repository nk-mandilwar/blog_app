class SubscribesController < ApplicationController

	def create
    @subscribe = Subscribe.new(subscriber_params)
    if @subscribe.save
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def unsubscribe
    @subscribe = Subscribe.find_by(id: params[:id])
    if(@subscribe)
      @subscribe.destroy
      redirect_to root_path, notice: 'You unsubscribed successfully'
    else
      redirect_to root_path, notice: 'You have already unsubscribed'
    end  
  end

  private

  def subscriber_params
  	params.require(:subscribe).permit(:email)
  end
end
