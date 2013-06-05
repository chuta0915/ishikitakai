ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_url_options[:host] = Figaro.env.host||'localhost'
