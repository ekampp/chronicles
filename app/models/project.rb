class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :name, type: String
  field :summary, type: String
  field :description, type: String
  field :url, type: String
  field :avatar, type: String
  field :avatar_cache, type: String

  # Associations
  embeds_many :project_types

  # Validations
  validates :name, presence: true
  validates :summary, presence: true

  # Uploaders
  mount_uploader :avatar, ProjectAvatarUploader
end
