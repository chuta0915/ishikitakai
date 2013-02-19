describe KptsController do
  nested_resources_should_routes 'groups', 'kpts', [:index, :create, :update, :destroy]
end
