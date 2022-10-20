# frozen_string_literal: true

class CreateBillingCycles < ActiveRecord::Migration[6.1]
  def change
    create_table :billing_cycles do |t|
      t.uuid :uid, default: 'gen_random_uuid()'
      t.date :date
      t.string :title
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
