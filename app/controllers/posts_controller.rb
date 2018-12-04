class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_post, only: [:show, :destroy]

	# for index. if user signed in retrieve 10 posts and display them
	def index
		#retrieve 10 posts from user and display on homepage
		@posted = Post.all.limit(10).includes(:photos, :user, :likes).order('created_at desc')
		@post = Post.new
	end

	# for create. Creating a new post
	def create
		#create new post
		@post = current_user.posts.build(post_params)
		if @post.save
			#if Success upload images to cloudinary (can handle multiple)
			if params[:images]
				params[:images].each do |img|
					@post.photos.create(image: img)
				end
			end
			#return uuser to the view
			redirect_to posts_path
			flash[:notice] = "Post saved"
		else
			#if failed return to view and alert user. 
			redirect_to posts_path
			flash[:alert] = "Something went wrong"
		end
	end

	# for show. single view display for the post selected
	def show
		#retrieve all info for the selected post
		@photos = @post.photos
		@likes = @post.likes.includes(:user)
		@comment = Comment.new
		@is_liked = @post.is_liked current_user
		@is_bookmarked = @post.is_bookmarked current_user
	end

	# for destroy. When deleting post
	def destroy
		#check if user is the owner of material he or she is trying to delete
		if @post.user == current_user
			#delete post
			if @post.destroy
				#if successful alert user success
				flash[:notice] = "post has been deleted"
			else
				#if failed alert user with failure
				flash[:alert]= "Something went wrong"
			end
		else
			#if not current user alert user it is not his or her post
			flash[:danger]= "you do not have permission to delete this post"
		end
		#send home
		redirect_to root_path
	end

	private
		
		# for find_post. finding post from current user selection 
		def find_post
			@post = Post.find_by id: params[:id]
			return if @post
			flash[:danger] = "Post Does Not Exist"
			redirect_to root_path
		end
		# for post_params
		def post_params
			params.require(:post).permit :title, :ingredients, :directions, :description, :cooktime, :preptime, :oventemp, :tempunits, :measurementunits, :genre 
		end
end