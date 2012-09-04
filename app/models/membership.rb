# encoding: utf-8
class Membership < ActiveRecord::Base
  attr_accessible :user_id, :level_id
  belongs_to :user
  belongs_to :group
  belongs_to :level

  before_save :check_master_level, if: Proc.new{|p| !p.new_record?}

  private
  def check_master_level
    master_level_id = Level.find_by_name('master').id

    # master以外に更新した場合は、
    # 当レコード以外にmaster以外が存在することを確認する
    unless self.level_id == master_level_id
      return self.group.memberships
        .where(level_id: master_level_id)
        .where('memberships.id NOT IN (?)', self.id)
        .exists?
    end
    true
  end
end
