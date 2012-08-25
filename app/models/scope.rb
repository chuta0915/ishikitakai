class Scope < ActiveRecord::Base
  def label
    I18n.t("scope.records.#{self.name}")
  end
end
