require_relative '../../shared/shared_scopes'
require_relative '../../shared/shared_actions'

module Communique
  class ReceivedMessage < ActiveRecord::Base

    include Shared::SharedActions
    extend Shared::SharedScopes

    attr_accessible :deleted, :message_id, :read, :recipient_id
    validates_uniqueness_of :message_id, scope: :recipient_id

    belongs_to :message
    belongs_to :recipient, class_name: "::User"

    delegate :content, :subject, :sender, to: :message

    default_scope order("created_at DESC")

    def self.read
      where(read: true)
    end

    def self.unread
      where(read: false)
    end

    def self.by_recipient(recipient)
      where(recipient_id: recipient.id)
    end

    def mark_as_read
      update_attribute :read, true
    end

    def mark_as_unread
      update_attribute :read, false
    end

    def was_received_by?(user)
      recipient == user
    end
  end
end
