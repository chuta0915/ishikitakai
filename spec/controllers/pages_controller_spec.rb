require 'spec_helper'

describe PagesController do
  request_should_be_success :get, :index
end
