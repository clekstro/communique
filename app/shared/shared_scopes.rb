module Shared
  module SharedScopes
    def deleted
      self.where(deleted: true)
    end
  end
end
