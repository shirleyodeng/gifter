class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  mount_uploader :photo, PhotoUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :guests
  has_many :participations
  has_many :events, through: :guests
  has_many :gifts, through: :events
  has_many :participations
  has_many :invitations, class_name: "Invite", foreign_key: 'recipient_id'
  has_many :sent_invites, class_name: "Invite", foreign_key: 'sender_id'

  def is_parent?
    Event.where(creator: self).any? ? true : false
  end

  def is_guest?
    Guest.where(user: self).any? ? true : false
  end

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
      user.remote_photo_url = auth.info.image
      user.save
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]
      user.remote_photo_url = auth.info.image
      user.save
    end
    return user
  end
end
