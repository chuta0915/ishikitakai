class Task < ActiveRecord::Base
  include Common::UserCreation
  attr_accessible :done, :group_id, :name
  belongs_to :created_user, class_name: 'User', foreign_key: 'created_user_id'
  belongs_to :completed_user, class_name: 'User', foreign_key: 'completed_user_id'

  validates_presence_of :name
  validates_length_of :name, minimum: 0, maximum: 200
  
  scope :search, lambda {|keyword| where(["
    name LIKE ?
    ", 
    "%#{keyword}%"
  ])}

  def user_id= user_id
    self.created_user_id = user_id
  end

  def complete
    self.done = true
    self.save
  end
end
