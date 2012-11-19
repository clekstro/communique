module Communique
  module Controllers
    module SecureAccess

      def self.is_message_recipient?(received_message, current_user_id)
        message = Communique::ReceivedMessage.find_by_id(received_message.id)
        return false unless message
        current_user_id == message.recipient_id
      end

      def self.is_message_sender?(message, current_user_id)
        message = Communique::Message.find_by_id(message.id)
        return false unless message
        current_user_id == message.sender_id
      end
    end
  end
end
