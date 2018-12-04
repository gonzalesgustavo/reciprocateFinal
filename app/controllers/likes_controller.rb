class LikesController < ApplicationController
	before_action :authenticate_user!

	# for create. Creates like and registers it with the model
	def create
		#create new like
		@like = current_user.likes.build(like_params)
		@post = @like.post
		if@like.save
			#if success let js handle it
 			respond_to :js
 		else
 			#if failed alert user
 			flash[:alert] = "something went wrong"
		end
	end

	# for destroy. removing like in case of accidental press or no longer liking post
	def destroy
		#find like by id
		@like = Like.find(params[:id])
		@post = @like.post
		if @like.destroy
			#if success then let js handle it
			respond_to :js
		else
			#if failed alert user
				flash[:alert] = "Something went wrong...."		
		end
	end

	private
		# for like_params
		def like_params
			params.permit :post_id
		end

end