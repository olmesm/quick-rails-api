class CreateWorkflowSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :workflow_steps do |t|
      t.belongs_to :workflow, foreign_key: true
      t.belongs_to :step, foreign_key: true

      t.timestamps
    end
  end
end
