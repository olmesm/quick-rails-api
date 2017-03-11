class AddUniqueIndexToBoardWorkflowsTable < ActiveRecord::Migration[5.0]
  def change
    add_index :board_workflows, [:board_id, :workflow_id], unique: true
  end
end
