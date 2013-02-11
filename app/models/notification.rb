class Notification < ActiveRecord::Base
  include Common::Markdown
  attr_accessible :content, :name, :read, :read_at, :trigger_type, :trigger_id, :type, :user_id
  belongs_to :user
  belongs_to :trigger, polymorphic: true

  validates_presence_of :name, :content

  scope :not_yet_read, lambda {
    where(read: false)
  }

  class << self
    def notify(users, params = {}, trigger = nil)
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

    def read_all(user)
      self.where(user_id: user.try(:id)).update_all(read_at: Time.current, read: true)
    end
  end

  def read_it
    self.reload
    self.read = true
    self.read_at = Time.current
    self.save
  end
end
