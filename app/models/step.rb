class Step < ApplicationRecord
  belongs_to :organization
  validates :name, presence: true, uniqueness: true
  has_many :workflow_steps
  has_many :step_tasks

  has_many :workflows, through: :workflow_steps
  has_many :tasks, through: :step_tasks
end
