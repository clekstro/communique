module Communique
  module Concerns
    module Trashable
      extend ActiveSupport::Concern
      
      def mark_as_trashed
        update_attribute :trashed, true
      end

      def unmark_as_trashed
        update_attribute :trashed, false
      end

      module ClassMethods
        def trashed
          where(trashed: true, deleted: false)
        end
      end

    end
  end
end
