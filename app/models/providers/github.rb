module Providers::Github
  def find_github(auth, current_user = nil)
    providers_user = ProvidersUser.find_by_provider_id_and_user_key Provider.github.id, auth['uid'].to_s

    name = auth['info']['nickname']
    image = auth['info']['image']
    email = auth['info']['email']||"#{auth['uid']}@github.example.com"
    
    if providers_user.nil?
      if current_user.nil?
        user = User.create!({
          name: name,
          email: email,
          image: image,
          default_provider_id: Provider.github.id,
        })
      else
        user = current_user
      end
      providers_user = ProvidersUser.create!({
        provider_id: Provider.github.id,
        user_id: user.id,
        user_key: auth['uid'].to_s,
        access_token: auth['credentials']['token'],
        name: name,
        email: email,
        image: image,
      })
    else
      user = User.find providers_user[:user_id]
      if current_user.nil?
        user.default_provider_id = Provider.github.id
        user.save!
      end
      if user.default_provider_id == Provider.github.id
        user.name = name
        user.image = image
        user.save!
      end
      
      providers_user.name = name
      providers_user.image = image
      providers_user.email = email
      providers_user.access_token = auth['credentials']['token']
      providers_user.save!
    end
    user
  end
end
