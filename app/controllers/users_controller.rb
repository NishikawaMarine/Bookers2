class UsersController < ApplicationController

	def show
	 	@book = Book.new
	 	@user = User.find(params[:id])
	end

	def index
	 	@book = Book.new
	 	@users =User.all
	 	@user = current_user
	end

	def edit
	 	@user = User.find(params[:id])
	 	if current_user != @user
	 		redirect_to user_path(current_user)
	 	end
	end

	def update
	 	@user = User.find(params[:id])
	 	if @user.update(user_params)
	 	   flash[:notice] = "successfully"
	 	   redirect_to user_path(current_user)
	 	else
	 		flash[:notice] = "error"
			render action: :edit
		end
	end

	def following
		@user = User.find(params[:id])
		@users = @user.followings
		render 'show_follow'
	end

	def followers
		@user = User.find(params[:id])
		@users = @user.followers
		render 'show_follower'
	end


	private
	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end
end

