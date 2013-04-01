class ContactAttempt
  include Mongoid::Document

  # Fields
  include Mongoid::Timestamps::Created
  field :name, type: String
  field :email, type: String
  field :url, type: String
  field :comment, type: String

  # Validations
  validates :name, presence: true
  validates :email, presence: true
  validates :comment, presence: true
end
