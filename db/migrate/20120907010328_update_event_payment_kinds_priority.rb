class UpdateEventPaymentKindsPriority < ActiveRecord::Migration
  def up
    e = EventPaymentKind.where(id:1).first
    e.priority = 1
    e.save!
    e = EventPaymentKind.where(id:3).first
    e.priority = 3
    e.save!
    EventPaymentKind.where(id:[2]).all.each do |scope|
      scope.priority = -1
      scope.save
    end
  end

  def down
    e = EventPaymentKind.where(id:2).first
    e.priority = 2
    e.save!
  end
end
