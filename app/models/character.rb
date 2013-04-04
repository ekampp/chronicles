class Character
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :public_bio, type: String
  field :private_bio, type: String

  belongs_to :user

  validates :name, presence: true
  validates :public_bio, presence: true
  validates :private_bio, presence: true
end
