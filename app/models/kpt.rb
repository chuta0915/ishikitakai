class Kpt < ActiveRecord::Base
  include Common::UserCreation
  attr_accessible :name, :group_id, :status, :user_id

  validates_presence_of :name
  validates_length_of :name, minimum: 0, maximum: 200

  KEEP = 1
  PROBLEM = 2
  TRY = 3
end
