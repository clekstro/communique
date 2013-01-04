module Communique
  class DraftMessage < AuthoredMessage

    def draft?
      true
    end

    def sent?
      false
    end

  end
end
