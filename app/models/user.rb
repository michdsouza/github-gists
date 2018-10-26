class User < ApplicationRecord
  def self.from_omniauth(auth)
    find_or_initialize_by(provider: auth.provider, uid: auth.uid).tap do |user|
      user.email       = auth.info.email
      user.uid         = auth.uid
      user.provider    = auth.provider
      user.avatar_url  = auth.info.image
      user.username    = auth.info.name
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end
end
