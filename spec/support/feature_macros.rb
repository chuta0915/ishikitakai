module FeatureMacros
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
    OmniAuth.config.test_mode = true
    auth[:provider] = provider
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(auth)
  end
end
