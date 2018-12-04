class CommentsController < ApplicationController
	before_action :authenticate_user!
	# for index
	def index
		@comments = @post.comments.includes(:user)
	end

	# for create. Creates new comment and registers it with the model
	def create
		#create new comment
		@comment = Comment.new(comment_params)
		if @comment.save
			#if save success send js handles the rest
			@post = @comment.post
			respond_to :js
		else
			# if fails alert user
			flash[:alert] = "Something went wrong"
		end
	end

	# for destroy. Removes comment
	def destroy
		#find comment by post id
		@comment = Comment.find(params[:id])
		@post = @comment.post
		#retain an instance
		if @comment.destroy
			#if success send to js to handle it
			respond_to :js
		else
			#if failed then alert user
			flash[:alert] = "Something went wrong...."
		end
	end
	private
		# for comment_params
		def comment_params
			params.require(:comment).permit :user_id, :post_id, :content
		end
end