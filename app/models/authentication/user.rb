class Authentication::User < ApplicationRecord
    self.table_name = "authhentication_users"

    validates :keycloak_id, presence: true, uniqueness: true
    validates :email, presence: true

  def self.find_or_create_from_keycloak(auth)
    user = find_by(keycloak_id: auth.uid)
    user || create(
      keycloak_id: auth.uid,
      email: auth.info.email,
      name: auth.info.name,
      access_token: auth.credentials.token,
      refresh_token: auth.credentials.token,
      token_expires_at: Time.zone.at(auth.credentials.expires_at)
    )
    user
  end

  def token_expired?
    token_expires_at && token_expires_at < Time.current
  end
end
