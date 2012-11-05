module Polymorphic::Commentable
  def self.included(base)
    base.belongs_to :user
    base.has_many :comments, :as => :commentable, :order => 'id ASC'
  end
end
