module Shared
  module SharedScopes

    def deleted
      self.where(deleted: true)
    end

    def present
      self.where(deleted: false)
    end

  end
end
