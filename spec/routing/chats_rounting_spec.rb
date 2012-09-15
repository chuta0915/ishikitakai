require "spec_helper"

describe ChatsController do
  nasted_resources_should_routes 'groups', 'chats', [:index, :show, :create, :destroy]
end
