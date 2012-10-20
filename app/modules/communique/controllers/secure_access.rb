module Communique
  module Controllers
    module SecureAccess
      def self.is_message_recipient?(message_reception, current_user_id)
        m = Communique::MessageReception.find_by_id(message_reception.id)
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
