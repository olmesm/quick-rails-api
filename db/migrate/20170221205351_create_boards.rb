class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.belongs_to :organization, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
