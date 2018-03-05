class Participation < ApplicationRecord
  belongs_to :gift
  belongs_to :user
  monetize :amount_cents
  validates :state, presence: true
end
