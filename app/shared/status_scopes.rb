module Shared
  module StatusScopes

    def trashed
      self.where(trashed: true, deleted: false)
    end

    def deleted
      self.where(deleted: true)
    end

    def present
      self.where(deleted: false, trashed: false)
    end

  end
end
