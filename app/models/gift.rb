class Gift < ApplicationRecord
  has_many :participations
  belongs_to :event
  monetize :price_cents
  validates :name, presence: true
  validates :description, presence: true
  mount_uploader :photo, PhotoUploader
end
