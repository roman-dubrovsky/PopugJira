class AddKindToBalances < ActiveRecord::Migration[6.1]
  def change
    add_column :balances, :source, :string
  end
end
