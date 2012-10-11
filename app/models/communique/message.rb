require_relative '../../concerns/shared_actions'

module Communique
  class Message < ActiveRecord::Base
    attr_accessible :content, :deleted, :draft, :sender_id, :subject
    attr_accessor :recipients

    include Concerns::SharedActions

    belongs_to :sender, class_name: "::User"
    validates_presence_of :sender_id, :recipients, :subject, :content

    def initialize
      super
      @deleted = false
      @draft = true
    end

    def send_message
      unmark_as_draft if draft
      # create MessageReception for each recipient
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
