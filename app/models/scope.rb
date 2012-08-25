class Scope < ActiveRecord::Base
  include Common::EnableList
  def label
    I18n.t("scope.records.#{self.name}")
  end
end
