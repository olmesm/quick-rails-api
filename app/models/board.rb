class Board < ApplicationRecord
  belongs_to :organization
  validates :name, presence: true, uniqueness: true
  has_many :board_workflows

  has_many :workflows, through: :board_workflows
end
