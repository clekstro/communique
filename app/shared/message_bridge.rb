require_relative '../models/communique/message_reception'

module Shared
  module MessageBridge
    def self.send_message(message)
      unless message.recipients.empty?
        message.recipients.each do |recipient|
          Communique::MessageReception.create!({
            message_id: message.id,
            recipient_id: recipient.id,
          })
        end
      end
    end
    def self.sent_on(message)
      Communique::MessageReception.find_by_message_id(message.id).created_at
    end
  end
end