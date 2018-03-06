class User < ApplicationRecord

  mount_uploader :photo, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events, dependent: :destroy
  has_many :gifts, through: :events
  validates :first_name, presence: true
  validates :last_name, presence: true


  def is_parent?
    Event.where(user_id: self.id).any? ? true : false
  end
end
