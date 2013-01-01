module FeatureMacros
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
  end

  def sign_in user, provider
    auth = 
    {
      'uid' => '123456',
      'info' => {
        'name' => user.name,
        'nickname' => user.name,
        'image' => user.image,
        'email' => user.email,
      },
      'credentials' => {
        'token' => 'token',
        'secret' => 'secret'
      },
      'extra' => {
        'raw_info' => {
          'avatar_url' => user.image
        }
      }
    }
    auth[:provider] = provider
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider.to_sym] = OmniAuth::AuthHash.new(auth)
  end
end
