module ApplicationHelper
	def avatar_url user
		return user.image if user.image
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		# "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
		"https://cdn.pixabay.com/photo/2016/04/01/09/55/bake-1299672_960_720.png"
	end
end
