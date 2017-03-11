class StepTask < ApplicationRecord
  belongs_to :step
  belongs_to :task
end
