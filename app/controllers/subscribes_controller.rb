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

  def destroy
    @subscribe = Subscribe.find_by(email: params[:subscribe][:email])
    if(@subscribe)
      @subscribe.destroy
      redirect_to root_path, notice: 'You unsubscribed successfully'
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
