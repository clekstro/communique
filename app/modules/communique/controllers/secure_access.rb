module Communique
  module Controllers
    module SecureAccess
      def self.is_message_recipient?(message_reception_id)
        m = Communique::MessageReception.find_by_id(message_reception_id)
        return false unless m
        current_user_id == m.id
      end
      
      def self.is_message_sender?(message_id)
        m = Communique::Message.find_by_id(message_id)
        return false unless m
        current_user_id == m.id
      end

      def current_user_id
        current_user.id
      end
    end
  end
end
