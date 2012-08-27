class Wiki < ActiveRecord::Base
  attr_accessible :content, :name, :parent_id, :parent_type, :user_id
end
