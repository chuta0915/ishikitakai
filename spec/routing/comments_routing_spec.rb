describe CommentsController do
  nested_resources_should_routes 'events', 'comments', [:create]
end
