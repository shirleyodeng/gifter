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
  validates :uid, presence: true
  validates :child_photo, presence: true
  mount_uploader :child_photo, PhotoUploader

  def child
    self.child_name.capitalize
  end

  def generate_uid
    self.uid = Digest::SHA1.hexdigest([self.user_id, Time.now, rand].join)
  end

  def has_contributions?
    participations = 0
    self.gifts.each do |gift|
      participations += 1 if gift.participations.present?
    end
    participations > 0 ? true : false
  end

  def total_raised
    sum = 0
    total = 0
    self.gifts.each do |gift|
      total += gift.price
      gift.participations.where(state: 'paid').each do |participation|
        sum += participation.amount
      end
    end
    return (sum / total).to_f
  end

end
