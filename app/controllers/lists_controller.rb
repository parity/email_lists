class ListsController < ApplicationController
	def new
		@list= List.new
	end

	def create
		@list = List.create(list_params)
		if @list.save
			flash[:success] = "New List Created, hence the List Information."
			redirect_to @list
		else
			render 'new'
		end
	end

	def show
		@list = List.find(params[:id])
	end

	private

		def list_params
      		params.require(:list).permit(:name, :description, :address)
    	end

end