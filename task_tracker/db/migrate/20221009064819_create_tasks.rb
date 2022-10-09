class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.references :creator, null: false, index: true
      t.references :owner, null: false, index: true
      t.boolean :active, default: true
      t.uuid :uid, default: "gen_random_uuid()"

      t.timestamps
    end
  end
end
