class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events, dependent: :destroy
  has_many :gifts, through: :events
  validates :first_name, presence: true
  validates :last_name, presence: true
  mount_uploader :photo, PhotoUploader

  def is_parent?
    Event.where(user_id: self.id).any? ? true : false
  end
end
