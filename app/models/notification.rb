class Notification < ActiveRecord::Base
  attr_accessible :content, :name, :read, :read_at, :trigger_type, :trigger_id, :type, :user_id
  belongs_to :user

  scope :not_yet_read, lambda {
    where(read: false)
  }

  class << self
    def notify users, params = {}, trigger = nil
      users.each do|user|
        self.create do |n|
          n.user_id = user.id
          if trigger.present?
            n.trigger_type = trigger.class.to_s
            n.trigger_id = trigger.try(:id)
          end
          n.name = params[:name]
          n.content = params[:content]
        end
      end
    end
  end

  def read_it
    self.read = true
    self.read_at = Time.current
    self.save
  end
end
