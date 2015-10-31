class User < ActiveRecord::Base
  
  has_secure_password :validations => false

  #before_save { |user| user.email = email.downcase }

  validates :uid, uniqueness: true

  has_many :contents, dependent: :destroy
  
  def self.find_or_create_from_auth(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
      name: auth_hash.info.name,
      nickname: auth_hash.info.nickname,
      profile_image: auth_hash.info.image,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
    user
  end
end
