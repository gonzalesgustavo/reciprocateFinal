class BookmarksController < ApplicationController
	before_action :authenticate_user!

	# for create
	def create
		#create new bookmark
		@bookmark = current_user.bookmarks.build(bookmark_params)
		#if successful 
		if @bookmark.save
			#update variable and pass to js
			@post = @bookmark.post
			@is_bookmarked = @bookmark
			respond_to :js
		else
			#if fails show message
			flash[:alert] = "Something went wrong"
		end
	end

	# for destroy. Destroy bookmark ie remove
	def destroy
		#find by post id
		@bookmark = Bookmark.find(params[:id])
		@post = @bookmark.post
		#save an instance of the post
		if @bookmark.destroy
			#if success send to js to handle
			respond_to :js
		else
			#if failed alert user
			flash[:alert] = "Something went wrong...."
		end
	end
	private
		# for bookmark_params
		def bookmark_params
			params.permit :user_id, :post_id
		end
end