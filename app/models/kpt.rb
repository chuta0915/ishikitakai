class Kpt < ActiveRecord::Base
  attr_accessible :name, :group_id, :status, :user_id
  KEEP = 1
  PROBLEM = 2
  TRY = 3
end
