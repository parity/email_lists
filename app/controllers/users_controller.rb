class UsersController < ApplicationController
	before_action :verify_admin, except: [:edit_password,:update_password]
	
	def index
		@users =User.where(role_id: 2).paginate(page: params[:page]).order("name ASC")
	end

	def new
   	@user = User.new
 	end
  
 	def show
  	@user = User.find(params[:id])
  end
  
 	def create
    @user = User.new(user_params)
    if @user.save
    	flash[:success] = "New user created, hence the user information. User password is: firstname_1234567"
    	redirect_to @user
    else
    	render 'new'
    end
	end

	def edit_password
		@user = User.find(params[:id])
	end

	def update_password
		@user= User.find(params[:id])
		if @user.valid_password?(params[:user][:current_password])
			if @user.update_attributes({password: params[:user][:password], password_confirmation: params[:user][:password_confirmation]})
				redirect_to root_url, :notice => "User password upated successfully"
			else
				render 'edit_password'
			end
		else
			@user.errors.add("current_password", "password does not matched")
			render 'edit_password'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user= User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "User Information updated, hence new profile"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted. Say Goodbye!"
    flash[:alert] = "Subcriptions of this user are gone too."
    redirect_to users_url
  end

	private

		def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end	