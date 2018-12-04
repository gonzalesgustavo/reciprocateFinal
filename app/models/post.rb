class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> {order(:created_at => :desc)}
  has_many :comments, -> {order(:created_at => :desc)}
  has_many :bookmarks

  # for is_belongs_to? user
  def is_belongs_to? user
  	Post.find_by(user_id: user.id, id: id)
  end

  # for is_liked user 
  def is_liked user
  	Like.find_by(user_id: user.id, post_id: id)
  end

  # for is_bookmarked user
  def is_bookmarked user
    Bookmark.find_by(user_id: user.id, post_id: id)
  end
end
