class SubscriptionsController < ApplicationController
	before_action :authenticate_user!, :verify_admin
	
	def new
 		@subscription = Subscription.new
 		@users = User.all
 		@lists = List.all
 	end

 	def create
 		begin
 			@subscription = Subscription.new(subscription_params)
			if @subscription.save
				flash[:success] = "New Subscription created, hence the Subscription Information."
				redirect_to @subscription
			end
 		rescue Exception => e
 			@subscriptions = Subscription.paginate(page: params[:page]).order("user_id ASC")
 			flash[:error] = e.message
 			render 'index' 			
 		end
	end

	def show
		@subscription = Subscription.find(params[:id])
	end

	def index
		@subscriptions = Subscription.paginate(page: params[:page]).order("user_id ASC")
	end

	def destroy
    Subscription.find(params[:id]).destroy
    flash[:success] = "Subscription deleted. Say Goodbye!"
    redirect_to subscriptions_url
  end

	private
	
		def subscription_params
    	params.require(:subscription).permit(:user_id, :list_id)
  	end
end