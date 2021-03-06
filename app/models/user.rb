class User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    puts auth_hash
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create!
    user.update!(
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret,
      name: auth_hash.info.name
    )
    user
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets[:twitter_api_key]
      config.consumer_secret     = Rails.application.secrets[:twitter_api_secret]
      config.access_token        = token
      config.access_token_secret = secret
    end
  end
end
