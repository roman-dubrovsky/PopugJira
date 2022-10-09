class CreateTaskStateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :task_state_logs do |t|
      t.references :task, null: false, index: true
      t.references :actor, null: true, index: true
      t.references :owner, null: true, index: true
      t.string :event

      t.timestamps
    end
  end
end
