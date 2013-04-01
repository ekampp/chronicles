class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :name, type: String
  field :uid, type: String
  field :provider, type: String, default: "twitter"
  field :role, type: Symbol, default: :user
  field :session_token, type: String
  field :email, type: String
  field :receive_newsletter, type: Boolean, default: false

  # Validations
  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
  validates :session_token, presence: true
  validates :role, presence: true,
    inclusion: { in: [ :user, :admin ] }

  def self.find_by_auth_hash hash, current_user=nil
    user = current_user
    user ||= where(uid: hash.uid, provider: hash.provider).first
    if user.present?
      i18n_key = "updated"
    else
      user ||= User.new
      i18n_key = "created"
    end

    user.attributes = {
      name: hash.info.name,
      uid: hash.uid,
      provider: hash.provider,
      session_token: SecureRandom.urlsafe_base64
    }
    user.save
    [ user, i18n_key ]
  end
end
