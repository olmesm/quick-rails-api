class Task < ApplicationRecord
  belongs_to :organization
  validates :name, presence: true, uniqueness: true
  has_many :step_tasks
  
  has_many :steps, through: :step_tasks
end
