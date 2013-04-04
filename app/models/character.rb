class Character
  include Mongoid::Document
  include Mongoid::Timestamps

  PROGRESS_FIELDS = [ :name, :public_bio, :private_bio ]

  field :name, type: String
  field :public_bio, type: String
  field :private_bio, type: String
  field :avatar, type: String
  field :avatar_cache, type: String

  belongs_to :user

  mount_uploader :avatar, CharacterAvatarUploader

  validates :name, presence: true

  # Returns the progress of the character
  # This is based on the number of correctly filled fields that's also defined
  # in the PROGRESS_FIELDS constant.
  #
  def progress
    (PROGRESS_FIELDS.reject{ |f| send(f).blank? }.count.to_f/
      PROGRESS_FIELDS.count.to_f*100).ceil
  end
end
