class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, index: true
      t.references :billing_cycle, null: false, index: true
      t.references :task, null: true, index: true

      t.monetize :debit
      t.monetize :credit
      t.uuid :uid, default: 'gen_random_uuid()'
      t.string :kind

      t.timestamps
    end
  end
end
