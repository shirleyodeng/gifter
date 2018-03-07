class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :gifts, dependent: :destroy
  has_many :guests
  has_many :users, through: :guests
  has_many :invites
  validates :name, presence: true
  validates :date, presence: true
  validates :child_name, presence: true
  validates :account_name, presence: true
  validates :sort_code, presence: true
  validates :account_number, presence: true
  mount_uploader :child_photo, PhotoUploader
end
