class AddUidToTaskStateLog < ActiveRecord::Migration[6.1]
  def change
    add_column :task_state_logs, :public_id, :uuid, default: "gen_random_uuid()"
  end
end
