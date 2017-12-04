json.(category, :id, :name, :created_at, :updated_at)

json.subscribe_path subscribe_category_path(category)
json.unsubscribe_path unsubscribe_category_path(category)
json.owner category.owner
