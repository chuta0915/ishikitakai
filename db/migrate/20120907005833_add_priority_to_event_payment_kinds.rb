class AddPriorityToEventPaymentKinds < ActiveRecord::Migration
  def change
    add_column :event_payment_kinds, :priority, :integer
    add_index :event_payment_kinds, :priority, :name => :idx_priority_on_event_payment_kinds
  end
end
