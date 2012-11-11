require_relative '../../shared/shared_actions'
require_relative '../../shared/message_scopes'
require_relative '../../shared/shared_scopes'
require_relative '../../shared/message_bridge'

module Communique
  class Message < ActiveRecord::Base
    before_save :trim_recipients

    include Shared::SharedActions
    extend Shared::MessageScopes
    extend Shared::SharedScopes

    attr_accessible :content, :deleted, :draft, :sender_id, :subject, :recipients

    belongs_to :sender, class_name: "::User"
    has_many :responses, class_name: "Communique::Message", foreign_key: "response_id"
    belongs_to :responds_to, class_name: "Communique::Message", foreign_key: "response_id"

    validates_presence_of :sender_id, :recipients, :subject, :content

    default_scope order("created_at DESC")

    def initialize
      super
      write_attribute(:deleted, false)
      write_attribute(:draft, true)
    end

    def send_message
      unmark_as_draft if draft
      # raise error if no users found in send_message
      MessageBridge::send_message(self)
    end

    def sent_on
      MessageBridge::sent_on(self)
    end

     def sent?
       draft == false
     end

    def mark_as_draft
      update_attribute :draft, true
    end

    def unmark_as_draft
      update_attribute :draft, false
    end

    private

    def trim_recipients
      self.recipients.gsub!(/\s+/, "")
    end
 end
end
