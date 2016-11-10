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
      if(@subscribe.security_ans == params[:subscribe][:security_ans])
        @subscribe.destroy
        redirect_to root_path, notice: 'You unsubscribed successfully'
      else
        render 'unsubscribe'
      end
    else
      redirect_to root_path
    end  
  end

  def unsubscribe
    @subscribe = Subscribe.new
  end

  private

  def subscriber_params
  	params.require(:subscribe).permit(:email, :security_ans)
  end
end
