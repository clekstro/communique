require_relative '../models/communique/received_message'

module MessageBridge
  def self.send_message(message)
    recipients = extract_recipients(message.recipients)
    unless recipients.empty?
      message_all_recipients(recipients, message.id)
      message.unmark_as_draft
      return true
    else
      message.errors[:base] << "No recipients found"
      return false
    end
  end

  def self.sent_on(message)
    Communique::ReceivedMessage.find_by_message_id(message.id).first.created_at
  end

  def self.extract_recipients(usernames)
    usernames = usernames.split(',')
    ::User.where(username: usernames).pluck(:id)
  end

  def self.message_all_recipients(recipients, message_id)
    recipients.each { |recipient| message_single_recipient(recipient, message_id) }
  end

  def self.message_single_recipient(recipient, message_id)
    Communique::ReceivedMessage.create(
        message_id: message_id, recipient_id: recipient,
        deleted: false, read: false
    )
  end
end
