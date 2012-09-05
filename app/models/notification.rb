class Notification < ActiveRecord::Base
  attr_accessible :content, :name, :read, :read_at, :trigger_type, :trigger_id, :type, :user_id
end
