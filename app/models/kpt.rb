class Kpt < ActiveRecord::Base
  include Common::UserCreation
  attr_accessible :name, :group_id, :status, :user_id, :priority

  validates_presence_of :name
  validates_length_of :name, minimum: 0, maximum: 200

  attr_accessor :priority_ids

  after_save :update_priorities

  KEEP = 1
  PROBLEM = 2
  TRY = 3

  private
  def update_priorities
    ids = self.priority_ids.reverse
    ids.each_with_index do |id, priority|
      kpt = Kpt.where(id: id).update_all(priority: priority)
    end
  end
end
