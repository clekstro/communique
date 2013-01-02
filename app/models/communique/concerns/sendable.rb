module Communique
  module Concerns
    module Sendable
      extend ActiveSupport::Concern
      
      included do
        belongs_to :sender, class_name: "::User"
        has_many :responses, class_name: "Communique::SentMessage", foreign_key: "response_id"
        belongs_to :responds_to, class_name: "Communique::SentMessage", foreign_key: "response_id"
      end

      def send_message
        Communique::MessageSender::send_message(self)
      end

      def was_sent_by?(user)
        sender == user
      end

      def sent?
        raise NotImplementedError
      end

      def sent_on
        updated_at
      end
    end
  end
end
