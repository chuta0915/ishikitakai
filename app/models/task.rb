class Task < ActiveRecord::Base
  attr_accessible :done, :group_id, :name
  belongs_to :created_user, class_name: 'User', foreign_key: 'created_user_id'
  belongs_to :completed_user, class_name: 'User', foreign_key: 'completed_user_id'

  def complete
    self.done = true
    self.save
  end
end
