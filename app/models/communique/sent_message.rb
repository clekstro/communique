module Communique
  class SentMessage < OutgoingMessage
    def sent?
      true
    end
  end
end
