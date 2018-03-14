class Event < ApplicationRecord
  before_validation :generate_uid
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :gifts, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :users, through: :guests
  has_many :invites
  has_many :conversations, dependent: :destroy
  validates :name, presence: true
  validates :date, presence: true
  validates :child_name, presence: true
  validates :account_name, presence: true
  validates :sort_code, presence: true
  validates :account_number, presence: true
  validates :uid, presence: true
  mount_uploader :child_photo, PhotoUploader

  def child
    self.child_name.capitalize
  end

  def generate_uid
    self.uid = Digest::SHA1.hexdigest([self.user_id, Time.now, rand].join)
  end
end
