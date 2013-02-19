describe TasksController do
  nested_resources_should_routes 'groups', 'tasks', [:index, :create, :update, :destroy]
end
