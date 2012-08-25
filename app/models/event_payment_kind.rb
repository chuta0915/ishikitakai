class EventPaymentKind < ActiveRecord::Base
  attr_accessible :name
  def label
    I18n.t("event_payment_kind.records.#{self.name}")
  end
end
