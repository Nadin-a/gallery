json.(category, :id, :name, :created_at, :updated_at)

json.subscibe_path subscribe_category_path(category)
json.unsubscibe_path unsubscribe_category_path(category)
json.owner category.owner
