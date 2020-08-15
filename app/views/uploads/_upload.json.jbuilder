json.extract! upload, :id, :image, :content, :name, :created_at, :updated_at
json.url upload_url(upload, format: :json)
