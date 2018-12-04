class PagesController < ApplicationController
	#check if user signed in and redirect(start new session)
  def home
  	if !user_signed_in?
  		redirect_to new_user_session_path
  	end
  end
end
