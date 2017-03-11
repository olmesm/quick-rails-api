class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :organization, foreign_key: true
      t.string :name
      t.text :description
      t.json :data

      t.timestamps
    end
  end
end
