class Gift < ApplicationRecord
  belongs_to :event
  belongs_to :user
  monetize :price_cents
  validates :name, presence: true
  validates :description, presence: true
  mount_uploader :photo, PhotoUploader
end
