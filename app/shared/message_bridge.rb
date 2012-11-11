require_relative '../models/communique/received_message'

module MessageBridge
  def self.send_message(message)
    recipients = extract_recipients(message.recipients)
    unless recipients.empty?
      recipients.each do |recipient|
        m = Communique::ReceivedMessage.new
        m.message_id = message.id
        m.recipient_id = recipient
        m.deleted = false
        m.read = false
        m.save
      end
    end
  end
  def self.sent_on(message)
    Communique::ReceivedMessage.find_by_message_id(message.id).first.created_at
  end
  def self.extract_recipients(usernames)
    usernames = usernames.split(',')
    ::User.where(username: usernames).pluck(:id)
  end
end
