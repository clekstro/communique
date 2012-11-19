module Shared
  module SharedActions

    def mark_as_deleted
      update_attribute :deleted, true
    end

    def unmark_as_deleted
      update_attribute :deleted, false
    end

  end
end
