module Communique
  module Concerns
    module Deletable
      extend ActiveSupport::Concern
      
      def mark_as_deleted
        update_attribute :deleted, true
      end

      def unmark_as_deleted
        update_attribute :deleted, false
      end

      module ClassMethods
        def deleted
          where(deleted: true)
        end
      end
      
    end
  end
end
