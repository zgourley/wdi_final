class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end


	def create
		@user = User.new(
			params.require(:user).permit(:name, :email, :github_handle, :password, :favorite_number))
		
		if @user.save
  			redirect_to root_path
		else
  			render 'new'
  		end
  	end
end
