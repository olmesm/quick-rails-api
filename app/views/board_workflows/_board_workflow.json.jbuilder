json.extract! board_workflow, :id, :board_id, :workflow_id, :data, :created_at, :updated_at
json.url board_workflow_url(board_workflow, format: :json)