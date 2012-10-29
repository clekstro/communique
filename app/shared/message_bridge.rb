require_relative '../models/communique/received_message'

module MessageBridge
  def self.send_message(message)
    unless message.recipients.empty?
      message.recipients.each do |recipient|
        m = Communique::ReceivedMessage.create({
          message_id: message.id,
          recipient_id: recipient.id,
          deleted: false,
          read: false
        })
      end
    end
  end
  def self.sent_on(message)
    Communique::ReceivedMessage.find_by_message_id(message.id).first.created_at
  end
end
