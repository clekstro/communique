require_relative '../models/communique/message_reception'

module MessageBridge
  def self.send_message(message)
    unless message.recipients.empty?
      message.recipients.each do |recipient|
        m = Communique::MessageReception.create({
          message_id: message.id,
          recipient_id: recipient.id,
          deleted: false,
          read: false
        })
      end
    end
  end
  def self.sent_on(message)
    Communique::MessageReception.find_by_message_id(message.id).created_at
  end
end
