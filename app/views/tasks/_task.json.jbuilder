json.extract! task, :id, :taskname, :deadline, :importance, :category, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)
