class AddAdditioanlInfoToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :public_id, :uuid, default: "gen_random_uuid()", null: false
    add_column :accounts, :full_name, :string
    add_column :accounts, :position, :string
  end
end
