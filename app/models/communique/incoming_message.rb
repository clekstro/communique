require_relative '../../shared/status_scopes'


module Communique
  class IncomingMessage < ActiveRecord::Base

    include Communique::Concerns::Deletable
    include Communique::Concerns::Trashable
    include Communique::Concerns::Readable

    extend Shared::StatusScopes

    attr_accessible :deleted, :trashed, :message_id, :read, :recipient_id
    validates_uniqueness_of :message_id, scope: :recipient_id

    belongs_to :message, class_name: "Communique::SentMessage"
    belongs_to :recipient, class_name: "::User"

    # forward all calls concerning message contents to SentMessage
    delegate :content, :subject, :sender, to: :message

    default_scope where(deleted: false).order("created_at DESC")

    def self.for(recipient)
      where(recipient_id: recipient.id)
    end

    def was_received_by?(user)
      recipient == user
    end
  end
end
