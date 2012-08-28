describe TasksController do
  nasted_resources_should_routes 'groups', 'tasks', [:index, :create, :update, :destroy]
end
