module Communique
  class SentMessage < AuthoredMessage
    def sent?
      true
    end
  end
end
