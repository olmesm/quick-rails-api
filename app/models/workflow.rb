class Workflow < ApplicationRecord
  belongs_to :organization
  validates :name, presence: true, uniqueness: true
  has_many :board_workflows
  has_many :workflow_steps

  has_many :boards, through: :board_workflows
  has_many :steps, through: :workflow_steps
end
