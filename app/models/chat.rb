class Chat < ActiveRecord::Base
  attr_accessible :content, :group_id, :user_id
end
