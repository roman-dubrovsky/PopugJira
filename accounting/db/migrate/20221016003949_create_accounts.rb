class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.uuid :uid
      t.string :email
      t.string :full_name
      t.string :role
      t.string :position

      t.timestamps
    end
  end
end
