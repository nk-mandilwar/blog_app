class SubscribesController < ApplicationController
	def create
    @subscribe = Subscribe.new(subscriber_params)
    @subscribe.save
    redirect_to :back
  end

  private
  def subscriber_params
  	params.require(:subscribe).permit(:email)
  end
end
