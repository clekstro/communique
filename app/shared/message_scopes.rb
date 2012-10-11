module Communique
  module Shared
    module MessageScopes
      def by_sender(id)
        where(sender_id: id)
      end
      def sent
        where(draft: false)
      end
      def draft
        where(draft: true)
      end
    end
  end
end
