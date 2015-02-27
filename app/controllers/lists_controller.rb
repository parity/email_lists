class ListsController < ApplicationController
	before_action :authenticate_user!, :verify_admin
	
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

	def index
		@lists =List.paginate(page: params[:page]).order("name ASC")
	end

	def destroy
	    List.find(params[:id]).destroy
	    flash[:success] = "List deleted. Say Goodbye!"
	    flash[:warning] = "Subcriptions to this list are gone too."
	    redirect_to lists_url
  	end

	private

		def list_params
      		params.require(:list).permit(:name, :description, :address)
    	end

end