  module Shared
    module RecipientActions
      def mark_as_read
        update_attribute :read, true
      end

      def mark_as_unread
        update_attribute :read, false
      end
    end
  end
