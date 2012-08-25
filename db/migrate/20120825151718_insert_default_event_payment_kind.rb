class InsertDefaultEventPaymentKind < ActiveRecord::Migration
  def up
    EventPaymentKind.create do |e|
      e.id = 1
      e.name = 'free'
    end
    EventPaymentKind.create do |e|
      e.id = 2
      e.name = 'advance'
    end
    EventPaymentKind.create do |e|
      e.id = 3
      e.name = 'deferred'
    end
  end

  def down
    EventPaymentKind.where(:id => [1, 2, 3]).delete_all
  end
end
