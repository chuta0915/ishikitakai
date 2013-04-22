require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'

  if Spork.using_spork?
    # Use of https://github.com/sporkrb/spork/wiki/Spork.trap_method-Jujitsu
    Spork.trap_method(Rails::Application, :reload_routes!)
    Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
   
   
    # Prevent main application to eager_load in the prefork block (do not load files in autoload_paths)
    Spork.trap_method(Rails::Application, :eager_load!)
  end
 
  # Below this line it is too late...
  require File.expand_path("../../config/environment", __FILE__)

  # Load all railties files
  Rails.application.railties.all { |r| r.eager_load! }

  require 'rspec/rails'
  require 'rspec/autorun'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false
    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # devise
    config.include Devise::TestHelpers, type: :controller
    config.include Devise::TestHelpers, type: :view
    config.include Devise::TestHelpers, type: :helper

    # factory_girl
    config.include FactoryGirl::Syntax::Methods

    # other macros
    config.include CommonMacros
    config.include ControllerMacros, type: :controller
    config.include ViewMacros, type: :view
    config.include RoutingResourcesMacros, type: :routing
    config.include FeatureMacros, type: :feature

    # For capybara
    require 'capybara/rspec'
    require 'capybara/poltergeist'
    Capybara.javascript_driver = :poltergeist

    config.before do
      Fog.mock!
      Fog::Mock.reset
      User.any_instance.stub(:save_to_s3).and_return(nil)
    end

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each) do
      if example.metadata[:js]
        DatabaseCleaner.strategy = :truncation
      else
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.start
      end
    end

    config.after(:each) do
      DatabaseCleaner.clean
      if example.metadata[:js]
        load "#{Rails.root}/db/seeds.rb"
      end
    end

    # master data
    load "#{Rails.root}/db/seeds.rb"
  end
end

Spork.each_run do
  # reload all the models
  Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
    load model
  end
  FactoryGirl.reload
end if Spork.using_spork?
