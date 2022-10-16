class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.uuid :uid
      t.string :title
      t.monetize :assign_price
      t.monetize :complete_price

      t.timestamps
    end
  end
end
