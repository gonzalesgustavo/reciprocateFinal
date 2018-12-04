class UsersController < ApplicationController
	
	# for index. Retrieve user
	def index
		@users = User.search(params[:term])
		respond_to :js
	end
	#show user that is signed in.
	def show
  		@user = User.find(params[:id])
  		@posts = @user.posts.includes(:photos, :likes, :comments)
  		@saved = Post.joins(:bookmarks).where(user_id: current_user.id).includes(:photos, :likes, :comments) if @user == current_user
	end

end
