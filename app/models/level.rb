class Level < ActiveRecord::Base
  def label
    I18n.t("level.records.#{self.name}")
  end
end
