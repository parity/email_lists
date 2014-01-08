class SubscriptionsController < ApplicationController
	def new
   		@subscription = Subscription.new
   		@users = User.all
   		@lists = List.all
 	end

 	def create
		@subscription = Subscription.new(subscription_params)
		if @subscription.save
			flash[:success] = "New Subscription created, hence the Subscription Information."
			redirect_to @subscription
		else
			render 'new'
		end
	end

	def show
		@subscription = Subscription.find(params[:id])
	end

	def index
		@subscriptions = Subscription.paginate(page: params[:page])
	end

	private

		def subscription_params
      		params.require(:subscription).permit(:user_id, :list_id)
    	end
end