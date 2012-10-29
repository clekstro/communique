module Communique
  module Controllers
    module SecureAccess
      def self.is_message_recipient?(received_message, current_user_id)
        m = Communique::ReceivedMessage.find_by_id(received_message.id)
        return false unless m
        current_user_id == m.recipient_id
      end
      
      def self.is_message_sender?(message, current_user_id)
        m = Communique::Message.find_by_id(message.id)
        return false unless m
        current_user_id == m.sender_id
      end
    end
  end
end
