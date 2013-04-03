class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :name, type: String
  field :email, type: String
  field :uid, type: String
  field :provider, type: String, default: "twitter"
  field :role, type: String, default: "user"
  field :token, type: String
  field :session_id, type: String
  field :age, type: Integer

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :session_id, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :role, presence: true, inclusion: [ "user", "gm", "admin" ]
  validates :age, presence: true, confirmation: true,
    numericality: { greater_than_or_equal_to: 16 }

  # Associations
  has_many :characters

  # Returns a user object based on the hash schema returned by the omniauth
  # gem.
  #
  def self.find_or_build_from_omniauth_hash hash, current_user = nil
    user = current_user
    user ||= User.all_of(uid: hash[:uid], provider: hash[:provider]).first
    user ||= User.new \
      uid: hash[:uid],
      provider: hash[:provider],
      name: hash[:info][:name],
      session_id: SecureRandom.urlsafe_base64

    # If we are building the user from an omniauth hash, it might be flawed. In
    # any case we should save it, so the user can edit the problems later.
    user.save validate: false

    user
  end
end
