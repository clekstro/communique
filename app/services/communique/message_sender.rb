module Communique
  module MessageSender
    def self.send_message(message)
      recipients = extract_recipients(message.recipients)
      unless recipients.empty?
        message_all_recipients(recipients, message.id)
        # set type so filters show message as sent
        message.type = 'Communique::SentMessage'
        message.save
        return true
      else
        message.errors[:base] << "No recipients found"
        return false
      end
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
        deleted: false, trashed: false, read: false
      )
    end
  end
end
