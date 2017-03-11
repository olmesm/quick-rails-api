class AddUniqueIndexToLinkTables < ActiveRecord::Migration[5.0]
  def change
    add_index :step_tasks, [:step_id, :task_id], unique: true
    add_index :workflow_steps, [:step_id, :workflow_id], unique: true
  end
end
