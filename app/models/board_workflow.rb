class BoardWorkflow < ApplicationRecord
  belongs_to :board
  belongs_to :workflow
end
