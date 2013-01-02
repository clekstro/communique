module Communique
  class DraftMessage < OutgoingMessage

    def draft?
      true
    end

    def sent?
      false
    end

  end
end
