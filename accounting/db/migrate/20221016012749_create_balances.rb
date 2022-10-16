class CreateBalances < ActiveRecord::Migration[6.1]
  def change
    create_table :balances do |t|
      t.references :account, null: false, index: true
      t.references :billing_cycle, null: false, index: true
      t.monetize :debit
      t.monetize :credit
      t.string :title
      t.uuid :uid, default: "gen_random_uuid()"
      t.string :metadata

      t.timestamps
    end
  end
end
