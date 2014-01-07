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

	def edit
		@list = List.find(params[:id])
	end	

	def update
		@list= List.find(params[:id])
		if @list.update_attributes(list_params)
			flash[:success] = "List Information updated, hence new profile"
			redirect_to @list
		else
			render 'edit'
		end
	end

	private

		def list_params
      		params.require(:list).permit(:name, :description, :address)
    	end

end