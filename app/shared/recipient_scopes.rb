module Communique
  module Shared
    module RecipientScopes
      def read
        where(read: true)
      end
      def unread
        where(read: false)
      end
    end
  end
end
