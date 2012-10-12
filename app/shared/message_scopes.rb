module Shared
  module MessageScopes
    def sent_by(sender)
      where(sender_id: sender.id)
    end
    def sent
      where(draft: false)
    end
    def draft
      where(draft: true)
    end
    def received_by(recipient)
      message_ids = Communique::MessageReception.where(recipient_id: recipient.id).pluck(:message_id)
      self.where(id: message_ids)
    end
    def recipients
      ::User.where(id: message_recipients)
    end
  end
end
