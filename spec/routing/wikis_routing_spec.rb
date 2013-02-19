describe WikisController do
  nested_resources_should_routes 'groups', 'wikis'
  nested_resources_should_routes 'events', 'wikis'
end
