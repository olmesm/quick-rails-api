class WorkflowStep < ApplicationRecord
  belongs_to :workflow
  belongs_to :step
end
