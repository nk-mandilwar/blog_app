class SubscribesController < ApplicationController

	def create
    @subscribe = Subscribe.new(subscriber_params)
    @subscribe.save
    redirect_to :back
  end

  def destroy
    @subscribe = Subscribe.find_by(email: params[:subscribe][:email])
    if(@subscribe)
      @subscribe.destroy
      redirect_to root_path
    else 
      render 'unsubscribe'
    end
  end

  def unsubscribe
    @subscribe = Subscribe.first
  end

  private

  def subscriber_params
  	params.require(:subscribe).permit(:email)
  end
end
