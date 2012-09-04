class Level < ActiveRecord::Base
  include Common::EnableList
  def label
    I18n.t("level.records.#{self.name}")
  end
end
