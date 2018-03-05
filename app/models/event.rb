class Event < ApplicationRecord
  belongs_to :user
  has_many :gifts, dependent: :destroy
  validates :name, presence: true
  validates :date, presence: true
  validates :child_name, presence: true
  validates :account_name, presence: true
  validates :sort_code, presence: true
  validates :account_number, presence: true
  mount_uploader :child_photo, PhotoUploader
end
