class AddOwnerToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :owner, null: true, index: true
  end
end
