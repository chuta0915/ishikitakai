module RoutingResourcesMacros
  def resources_should_routes resources, methods = [:index, :new, :show, :edit, :create, :destroy]
    id = '12345'
    describe "routing /#{resources} CRUD" do
      if methods.include? :index
        it "routes to #index" do
          get("/#{resources}").should route_to("#{resources}#index")
        end
      end
      if methods.include? :new
        it "routes to #new" do
          get("/#{resources}/new").should route_to("#{resources}#new")
        end
      end
      if methods.include? :show
        it "routes to #show" do
          get("/#{resources}/#{id}").should route_to("#{resources}#show", :id => id)
        end
      end
      if methods.include? :edit
        it "routes to #edit" do
          get("/#{resources}/#{id}/edit").should route_to("#{resources}#edit", :id => id)
        end
      end
      if methods.include? :post
        it "routes to #post" do
          post("/#{resources}").should route_to("#{resources}#create")
        end
      end
      if methods.include? :destroy
        it "routes to #destroy" do
          delete("/#{resources}/#{id}").should route_to("#{resources}#destroy", :id => id)
        end
      end
    end
  end

  def nasted_resources_should_routes parent, resources, methods = [:index, :new, :show, :edit, :create, :destroy]
    parent_id = '12345'
    id = '23456'
    describe "routing /#{parent}/:#{parent.singularize}_id/#{resources} CRUD" do
      if methods.include? :index
        it "routes to #index" do
          get("/#{parent}/#{parent_id}/#{resources}").should route_to("#{resources}#index", "#{parent.singularize}_id" => parent_id)
        end
      end
      if methods.include? :new
        it "routes to #new" do
          get("/#{parent}/#{parent_id}/#{resources}/new").should route_to("#{resources}#new", "#{parent.singularize}_id" => parent_id)
        end
      end
      if methods.include? :show
        it "routes to #show" do
          get("/#{parent}/#{parent_id}/#{resources}/#{id}").should route_to("#{resources}#show", "#{parent.singularize}_id" => parent_id, :id => id)
        end
      end
      if methods.include? :edit
        it "routes to #edit" do
          get("/#{parent}/#{parent_id}/#{resources}/#{id}/edit").should route_to("#{resources}#edit", "#{parent.singularize}_id" => parent_id, :id => id)
        end
      end
      if methods.include? :post
        it "routes to #post" do
          post("/#{parent}/#{parent_id}/#{resources}").should route_to("#{resources}#create", "#{parent.singularize}_id" => parent_id)
        end
      end
      if methods.include? :destroy
        it "routes to #destroy" do
          delete("/#{parent}/#{parent_id}/#{resources}/#{id}").should route_to("#{resources}#destroy", "#{parent.singularize}_id" => parent_id, :id => id)
        end
      end
    end
  end
end