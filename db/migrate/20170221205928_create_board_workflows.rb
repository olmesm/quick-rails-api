class CreateBoardWorkflows < ActiveRecord::Migration[5.0]
  def change
    create_table :board_workflows do |t|
      t.belongs_to :board, foreign_key: true
      t.belongs_to :workflow, foreign_key: true
      t.json :data

      t.timestamps
    end
  end
end
