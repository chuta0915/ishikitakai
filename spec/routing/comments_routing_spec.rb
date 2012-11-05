describe CommentsController do
  resources_should_routes 'groups', [:show, :destroy]
  nasted_resources_should_routes 'events', 'comments', [:create]
end
