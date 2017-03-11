json.extract! board, :id, :organization_id, :name, :created_at, :updated_at
json.url board_url(board, format: :json)