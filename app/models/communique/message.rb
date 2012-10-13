require_relative '../../shared/shared_actions'
require_relative '../../shared/message_scopes'
require_relative '../../shared/shared_scopes'

module Communique
  class Message < ActiveRecord::Base

    include Shared::SharedActions
    extend Shared::MessageScopes
    extend Shared::SharedScopes

    attr_accessible :content, :deleted, :draft, :sender_id, :subject, :recipients
    attr_accessor :recipients

    belongs_to :sender, class_name: "::User"
    validates_presence_of :sender_id, :recipients, :subject, :content

    default_scope where(deleted: false).order("created_at DESC")

    def initialize
      super
      write_attribute(:deleted, false)
      write_attribute(:draft, true)
    end

    def send_message
      unmark_as_draft if draft
      Shared::MessageBridge::send_message(self)
    end

    def sent_on
      Shared::MessageBridge::sent_on(self)
    end

    # def sent?
    #   !sent_on.nil?
    # end

    def mark_as_draft
      update_attribute :draft, true
    end

    def unmark_as_draft
      update_attribute :draft, false
    end
 end
end
