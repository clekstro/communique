require_relative '../../shared/shared_actions'
require_relative '../../shared/message_scopes'
require_relative '../../shared/shared_scopes'

module Communique
  class Message < ActiveRecord::Base
    attr_accessible :content, :deleted, :draft, :sender_id, :subject
    attr_accessor :recipients

    include Shared::SharedActions
    extend Shared::MessageScopes
    extend Shared::SharedScopes

    belongs_to :sender, class_name: "::User"
    validates_presence_of :sender_id, :recipients, :subject, :content

    def initialize
      super
      @deleted = false
      @draft = true
    end

    def send_message
      unmark_as_draft if draft

      unless recipients.empty?
        recipients.each do |recipient|
          MessageReception.create!({
            message_id: self.id,
            recipient_id: recipient.id,
          })
        end
      end
    end

    def mark_as_draft
      update_attribute :draft, true
    end

    def unmark_as_draft
      update_attribute :draft, false
    end
 end
end