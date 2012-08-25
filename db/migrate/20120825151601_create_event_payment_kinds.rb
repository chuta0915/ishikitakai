class CreateEventPaymentKinds < ActiveRecord::Migration
  def change
    create_table :event_payment_kinds do |t|
      t.string :name

      t.timestamps
    end
  end
end
