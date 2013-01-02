module Communique
  module Concerns
    module Readable
      extend ActiveSupport::Concern

      def mark_as_read
        update_attribute :read, true
      end

      def mark_as_unread
        update_attribute :read, false
      end

      module ClassMethods
        def read
          where(read: true)
        end

        def unread
          where(read: false)
        end
      end

    end
  end
end
