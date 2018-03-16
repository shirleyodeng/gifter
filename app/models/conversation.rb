class Conversation < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  belongs_to :event
  has_many :messages, dependent: :destroy
  validates :sender_id, :uniqueness => {:scope => [:recipient_id, :event_id]}
  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id = ? ) OR (conversations.sender_id = ? AND conversations.recipient_id = ? )", sender_id, recipient_id, recipient_id, sender_id)
  end
end
