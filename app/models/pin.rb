class Pin < ActiveRecord::Base
     belongs_to :user
     has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
     validates_attachment_content_type :image, :content_type => ["image/jpg","image/jpeg","image/png","image/gif"]
     validates :image, presence: true
  	 validates :description, presence: true
  	 acts_as_votable
  	 acts_as_commentable
  	 def score
  		self.get_upvotes.size - self.get_downvotes.size
  	 end
     def self.highest_voted
      self.order("cached_votes_score DESC")
     end
end 
