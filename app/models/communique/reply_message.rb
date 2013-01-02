module Communique
  class ReplyMessage
    include ActiveAttr::Model

    def initialize(message)
      @message = message
      @username = @message.sender.username
    end

    def recipients
      @username
    end

    def subject
      "Re: " + @message.subject
    end

    def content
      "\n#{@username} wrote:\n" + @message.content
    end
  end
end
