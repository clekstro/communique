require 'active_support/all'

module Communique
  module Concerns
    module SharedActions
      extend ActiveSupport::Concern
      included do
        def mark_as_deleted
          update_attribute :deleted, true
        end

        def unmark_as_deleted
          update_attribute :deleted, false
        end

      end
    end
  end
end
