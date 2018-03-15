class Gift < ApplicationRecord
  has_many :participations
  belongs_to :event
  monetize :price_cents
  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :price, presence: true
  mount_uploader :photo, PhotoUploader

  def amount_left
    sum = 0
    self.participations.where(state: 'paid').each do |participation|
      sum += participation.amount
    end
    self.price - sum
  end

  def amount_raised
    sum = 0
    self.participations.where(state: 'paid').each do |participation|
      sum += participation.amount
    end
    return sum / self.price
  end

  def capitalized_name
    self.name.split.map(&:capitalize).join(' ')
  end
end
